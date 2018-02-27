//
//  StatusViewModel.swift
//  weibo-swift
//
//  Created by fqq3 on 2018/2/1.
//  Copyright © 2018年 sandouchan. All rights reserved.
//

import UIKit

class StatusViewModel {
    // MARK:- 定义属性
    var status : StatusModel?
    
    // MARK:- 对数据处理的属性
    /// 处理来源
    var sourceText: String?
    /// 处理创建时间
    var createdAtStr: String?
    /// 处理用户认证图标
    var verifiedImage : UIImage?
    /// 处理用户会员等级
    var vipImage : UIImage?
    /// 处理用户头像的地址
    var profileURL : URL?
    /// 处理微博配图的数据
    var picURLs : [URL] = [URL]()
    
    init(status: StatusModel) {
        self.status = status
        
        // 1.对来源处理
        if let source = status.source, source != "" {
            let startIndex = (source as NSString).range(of: ">").location + 1
            let length = (source as NSString).range(of: "</").location - startIndex
            
            sourceText = (source as NSString).substring(with: NSRange(location: startIndex, length: length))
        }
        
        // 2.处理时间
        if let createAt = status.created_at {
            createdAtStr = NSDate.createDateString(createAtStr: createAt)
        }
        
        // 3.处理认证
        let verifiedType = status.user?.verified_type ?? -1
        
        switch verifiedType {
        case 0:
            verifiedImage = UIImage(named: "avatar_vip")
        case 2, 3, 5:
            verifiedImage = UIImage(named: "avatar_enterprise_vip")
        case 220:
            verifiedImage = UIImage(named: "avatar_grassroot")
        default:
            verifiedImage = nil
        }
        
        // 4.处理会员图标
        let mbrank = status.user?.mbrank ?? 0
        
        if mbrank > 0 && mbrank <= 6 {
            vipImage = UIImage(named: "common_icon_membership_level\(mbrank)")
        }
        
        // 5.用户头像的处理
        let profileURLString = status.user?.profile_image_url ?? ""
        profileURL = URL(string: profileURLString)
        
        // 6.处理配图数据
        let picURLDicts = status.pic_urls!.count != 0 ? status.pic_urls : status.retweeted_status?.pic_urls
        
        if let picURLDicts = picURLDicts {
            for picURLDict in picURLDicts {
                guard let picURLString = picURLDict["thumbnail_pic"] else { continue }
                
                picURLs.append(URL(string: picURLString)!)
            }
        }
    }
    
}
