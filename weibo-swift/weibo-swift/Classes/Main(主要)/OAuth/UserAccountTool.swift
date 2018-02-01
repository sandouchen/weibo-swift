//
//  UserAccountTool.swift
//  weibo-swift
//
//  Created by fqq3 on 2018/1/30.
//  Copyright © 2018年 sandouchan. All rights reserved.
//

import UIKit

class UserAccountTool {
    /// 设计单例
    static let shareInstance: UserAccountTool = UserAccountTool()
    
    var account: UserAccount?
    
    /// 计算属性 = 方法
    var accountPath: String {
        let accountPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        return "\(accountPath)/account.plist"
//        accountPath = (accountPath as NSString).appendingPathComponent("account.plist")
    }
    
    var isLogin: Bool {
        if account == nil { return false }
        
        guard let expiresDate = account?.expires_date else {
            return false
        }
        
        return expiresDate.compare(Date()) == ComparisonResult.orderedDescending
        
    }
    
    init() {
        // 从沙盒中读取归档信息
        account = NSKeyedUnarchiver.unarchiveObject(withFile: accountPath) as? UserAccount
    }
}
