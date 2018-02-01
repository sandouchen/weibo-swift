//
//  NetWorkTools.swift
//  weibo-swift
//
//  Created by fqq3 on 2018/1/25.
//  Copyright © 2018年 sandouchan. All rights reserved.
//

import AFNetworking

enum RequestType : String {
    case GET = "GET"
    case POST = "POST"
}

class NetWorkTools: AFHTTPSessionManager {
    /// 创建网络工具单例（let 是线程安全的）
    static let shareInstance : NetWorkTools = {
        let tools = NetWorkTools()
        tools.responseSerializer.acceptableContentTypes?.insert("text/html")
        tools.responseSerializer.acceptableContentTypes?.insert("text/plain")
        
        return tools
    }()
}

// MARK: - 封装AFNetworking
extension NetWorkTools {
    /// 封装 AFN 的 GET / POST 请求
    ///
    /// - Parameters:
    ///   - RequestType: GET / POST
    ///   - urlString: URLString
    ///   - parameters: 参数字典
    ///   - resultBlock: 完成回调[json(字典／数组), 是否成功]
    func request(RequestType: RequestType, urlString: String, parameters: [String : AnyObject], resultBlock: @escaping(_ result: AnyObject?, _ error: Error?) -> ()) {
        // 1 成功回调
        let successBlock = { (tack: URLSessionDataTask, result: Any) in
            resultBlock(result as AnyObject?, nil)
        }
        
        // 2 失败回调
        let failureBlock = { (task: URLSessionDataTask?, error: Error) in
            resultBlock(nil, error)
        }
        
        // get请求
        if RequestType == .GET {
            get(urlString, parameters: parameters, progress: nil, success: successBlock, failure: failureBlock)
        }
        
        // post请求
        if RequestType == .POST {
            post(urlString, parameters: parameters, progress: nil, success: successBlock, failure: failureBlock)
        }
    }

    /// 封装 AFN 的上传文件方法
    /// 上传文件必须是 POST 方法，GET 只能获取数据
    func upLoad(urlString: String, parameters: AnyObject?, constructingBodyWithBlock: ((_ formData: AFMultipartFormData) -> Void)?, uploadProgress: ((_ progress: Progress) -> Void)?, success: ((_ responseObject: AnyObject?) -> Void)?, failure: ((_ error: NSError) -> Void)?) -> Void {
        
        NetWorkTools.shareInstance.post(urlString, parameters: parameters, constructingBodyWith: { (formData) in
            
        }, progress: { (progress) in
            
        }, success: { (task, objc) in
            if objc != nil {
                success!(objc as AnyObject?)
            }
            
        }) { (task, error) in
            failure!(error as NSError)
        }
    }
}

// MARK: - 请求方法集合
extension NetWorkTools {
    /// 请求 AccessToken
    func loadAccessToken(code: String, finished: @escaping (_ result: [String : AnyObject]?, _ error: Error?) -> ()) {
        let url = "https://api.weibo.com/oauth2/access_token"
        
        let parameters = ["client_id" : appKey, "client_secret" : appSecret, "grant_type" : "authorization_code", "redirect_uri" : redirectUri, "code" : code]
        
        request(RequestType: .POST, urlString: url, parameters: parameters as [String : AnyObject]) { (result, error) in
            finished(result as? [String : AnyObject], error)
        }
    }

    /// 请求用户信息
    func loadUserInfo(access_token: String, uid : String, finished: @escaping (_ result: [String : AnyObject]?, _ error: Error?) -> ()) {
        let url = "https://api.weibo.com/2/users/show.json"
        
        let parameters = ["access_token" : access_token, "uid" : uid]
        
        request(RequestType: .GET, urlString: url, parameters: parameters as [String : AnyObject]) { (result, error) in
            finished(result as? [String : AnyObject], error)
        }
    }

    /// 获取微博信息
    func loadNewWeiBo(finished: @escaping(_ result: [[String : AnyObject]]?, _ error: Error?) -> ()) {
        let url = "https://api.weibo.com/2/statuses/home_timeline.json"
        
        let parameters = ["access_token" : (UserAccountTool.shareInstance.account?.access_token)!]
        
        request(RequestType: .GET, urlString: url, parameters: parameters as [String : AnyObject]) { (result, error) in
            // 获取字典的数组数据
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            
            // 将数组数据回调给外界控制器
            finished(resultDict["statuses"] as? [[String : AnyObject]], error)
        }
    }



}









