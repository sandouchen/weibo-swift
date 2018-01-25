//
//  UIBarButtonItem-Extension.swift
//  weibo-swift
//
//  Created by fqq3 on 2018/1/23.
//  Copyright © 2018年 sandouchan. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    /// 快速创建导航栏按钮
    convenience init(imageName: String, target: Any?, action: Selector) {
        self.init()
        
        let btn = UIButton()
        
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.setImage(UIImage(named: imageName + "_highlighted"), for: .highlighted)
        btn.sizeToFit()
        
        btn.addTarget(target, action: action, for: .touchUpInside)
        
        self.customView = btn
    }
}
