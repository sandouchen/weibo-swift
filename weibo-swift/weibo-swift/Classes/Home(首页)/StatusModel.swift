//
//  StatusModel.swift
//  weibo-swift
//
//  Created by fqq3 on 2018/1/30.
//  Copyright © 2018年 sandouchan. All rights reserved.
//

import UIKit
@objcMembers
class StatusModel: NSObject {
    // MARK:- 属性
    /// 微博创建时间
    var created_at : String?
    /// 微博来源
    var source : String?
    /// 微博的正文
    var text : String?
    /// 微博的ID
    var mid : Int = 0
    /// 用户信息模型
    var user : UserModel?
    /// 微博的配图
    var pic_urls : [[String : String]]?
    /// 微博对应的转发的微博
    var retweeted_status : StatusModel?
    
    init(dict: [String : AnyObject]) {
        super.init()
        setValuesForKeys(dict)
        
        // 将用户字典转成用户模型对象
        if let userDict = dict["user"] as? [String : AnyObject] {
            user = UserModel(dict: userDict)
        }
        
        // 2.将转发微博字典转成转发微博模型对象
        if let retweetedStatusDict = dict["retweeted_status"] as? [String : AnyObject] {
            retweeted_status = StatusModel(dict: retweetedStatusDict)
        }
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
