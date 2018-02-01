//
//  UserAccount.swift
//  weibo-swift
//
//  Created by fqq3 on 2018/1/26.
//  Copyright © 2018年 sandouchan. All rights reserved.
//

import UIKit

@objcMembers

class UserAccount: NSObject, NSCoding {
    
    var access_token: String?
    var expires_in: TimeInterval = 0.0 {
        didSet {
            expires_date = NSDate(timeIntervalSinceNow:expires_in)
        }
    }
    var uid: String?
    
    var expires_date: NSDate?
    
    var screen_name: String?
    var avatar_large: String?
    
    
    init(dict: [String : AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    /// 重写 KVC 方法以免报错
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
    /// 重写description属性
    override var description: String {
        return dictionaryWithValues(forKeys: ["access_token", "expires_date", "uid", "avatar_large", "screen_name"]).description
    }
    
    /// 归档
    func encode(with aCoder: NSCoder) {
        aCoder.encode(access_token, forKey: "access_token")
        aCoder.encode(expires_date, forKey: "expires_date")
        aCoder.encode(uid, forKey: "uid")
        aCoder.encode(avatar_large, forKey: "avatar_large")
        aCoder.encode(screen_name, forKey: "screen_name")
    }
    
    /// 解档
    required init?(coder aDecoder: NSCoder) {
        access_token = aDecoder.decodeObject(forKey: "access_token") as? String
        expires_date = aDecoder.decodeObject(forKey: "expires_date") as? NSDate
        uid = aDecoder.decodeObject(forKey: "uid") as? String
        avatar_large = aDecoder.decodeObject(forKey: "avatar_large") as? String
        screen_name = aDecoder.decodeObject(forKey: "screen_name") as? String
    }
}
