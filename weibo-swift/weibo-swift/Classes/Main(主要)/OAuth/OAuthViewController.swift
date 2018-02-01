//
//  OAuthViewController.swift
//  weibo-swift
//
//  Created by fqq3 on 2018/1/26.
//  Copyright © 2018年 sandouchan. All rights reserved.
//

import UIKit
import SVProgressHUD

class OAuthViewController: UIViewController {

    @IBOutlet weak var oauthWebView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        
        loadOAuthWebView()
    }

}

// MARK: - 设置 UI 界面
extension OAuthViewController {
    /// 设置导航栏按钮
    private func setupNavigationBar() {
        title = "授权"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(OAuthViewController.cancalBtnClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "填充", style: .plain, target: self, action: #selector(OAuthViewController.fillBtnClick))
    }
    
    /// 加载授权页面
    private func loadOAuthWebView() {
        let urlStr = "https://api.weibo.com/oauth2/authorize?client_id=\(appKey)&redirect_uri=\(redirectUri)"
        guard let url = URL(string: urlStr) else {
            return
        }
        let request = URLRequest(url: url)
        oauthWebView.loadRequest(request)
    }
}

// MARK: - 事件监听
extension OAuthViewController {
    @objc private func cancalBtnClick() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func fillBtnClick() {
        let jsCode = "document.getElementById('userId').value='cbh_ken@163.com';document.getElementById('passwd').value='Sandou840722';"
        oauthWebView.stringByEvaluatingJavaScript(from: jsCode)
    }
}

// MARK: - UIWebViewDelegate
extension OAuthViewController: UIWebViewDelegate {
    func webViewDidStartLoad(_ webView: UIWebView) {
        SVProgressHUD.show(withStatus: "正在加载")
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        SVProgressHUD.dismiss()
    }
    
    // 当准备加载某一个页面时,会执行该方法
    // 返回值: true -> 继续加载该页面 false -> 不会加载该页面
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        guard let url = request.url else {
            return true
        }
        
        // url转字符串
        let urlStr = url.absoluteString
        
        // 判断字符串是否包含 code
        guard urlStr.contains("code=") else {
            return true
        }
        
        // 截取 code
        let codeStr = urlStr.components(separatedBy: "code=").last!
        
        // 请求 accessToken
        loadAccessToken(codeStr: codeStr)
        
        return false
    }
}

// MARK: - 请求数据
extension OAuthViewController {
    /// 请求 accessToken
    private func loadAccessToken(codeStr: String) {
        NetWorkTools.shareInstance.loadAccessToken(code: codeStr) { (result, error) in
            
            if error != nil {
                SDLog(error)
                return
            }
            
            guard let accountDict = result else {
                SDLog("没有数据")
                return
            }
            
            let account = UserAccount(dict: accountDict)

            self.loadUserInfo(account: account)
        }
    }
    
    /// 请求用户信息
    private func loadUserInfo(account: UserAccount) {
        
        guard let tokenStr = account.access_token else {
            return
        }
        
        guard let uidStr = account.uid else {
            return
        }
        
        NetWorkTools.shareInstance.loadUserInfo(access_token: tokenStr, uid: uidStr) { (result, error) in
            
            if error != nil {
                SDLog(error)
                return
            }
            
            guard let userInfoDict = result else {
                return
            }
            
            account.screen_name = userInfoDict["screen_name"] as? String
            account.avatar_large = userInfoDict["avatar_large"] as? String
            
            // 将 account 对象保存
            SDLog(UserAccountTool.shareInstance.accountPath)
            NSKeyedArchiver.archiveRootObject(account, toFile: UserAccountTool.shareInstance.accountPath)
            
            // 将 account 对象设置到单例对象中
            UserAccountTool.shareInstance.account = account
            
            // 显示欢迎页面
            self.dismiss(animated: false, completion: {
                UIApplication.shared.keyWindow?.rootViewController = WelcomeViewController()
            })
        }
    }
    
}










