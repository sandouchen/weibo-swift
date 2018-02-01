//
//  UserModel.swift
//  weibo-swift
//
//  Created by fqq3 on 2018/2/1.
//  Copyright © 2018年 sandouchan. All rights reserved.
//

import UIKit
@objcMembers
class UserModel: NSObject {
    // MARK:- 属性
    /// 用户的头像
    var profile_image_url : String?
    /// 用户的昵称
    var screen_name : String?
    /// 用户的认证类型
    var verified_type : Int = -1
    /// 用户的会员等级
    var mbrank : Int = 0
    
    init(dict: [String : AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
