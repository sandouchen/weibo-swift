//
//  WelcomeViewController.swift
//  weibo-swift
//
//  Created by fqq3 on 2018/1/30.
//  Copyright © 2018年 sandouchan. All rights reserved.
//

import UIKit
import SDWebImage

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var iconViewBottomCons: NSLayoutConstraint!
    
    @IBOutlet weak var iconView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let profileURLStr = UserAccountTool.shareInstance.account?.avatar_large
        // ??：前面可选类型有值就解包并赋值，为 nil 直接使用后面的值
        let url = URL(string: profileURLStr ?? "")
        
        iconView.layer.cornerRadius = iconView.bounds.size.width * 0.5
        iconView.layer.masksToBounds = true
        
        iconView.sd_setImage(with: url, placeholderImage: UIImage(named: "avatar_default_big"))
        
        iconViewBottomCons.constant = UIScreen.main.bounds.height - 300
        
        UIView .animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 5, options: [], animations: {
            self.view.layoutIfNeeded()
        }) { (_) in
            UIApplication.shared.keyWindow?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        }
    }

}
