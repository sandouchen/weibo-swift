//
//  MainViewController.swift
//  weibo-swift
//
//  Created by fqq3 on 2018/1/19.
//  Copyright © 2018年 sandouchan. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        setupTabBarVc()
        
        
        
    }
    
}

// MARK: - 初始化TabBarVc
extension MainViewController {
    /// 初始化TabBarVc
    func setupTabBarVc() {
        addChildViewController(childVc: HomeViewController(), title: "首页", imageName: "tabbar_home")
        addChildViewController(childVc: DiscoverViewController(), title: "消息", imageName: "tabbar_message_center")
        addChildViewController(childVc: MessageViewController(), title: "发现", imageName: "tabbar_discover")
        addChildViewController(childVc: ProfileViewController(), title: "我", imageName: "tabbar_profile")
    }
}

// MARK: - 重写 addChildViewController
extension MainViewController {
    /// 重写 addChildViewController
    private func addChildViewController(childVc: UIViewController, title : String, imageName : String) {
        childVc.title = title
        childVc.tabBarItem.image = UIImage(named: imageName)
        childVc.tabBarItem.selectedImage = UIImage(named: imageName + "_highlighted")
        
        let childNav = UINavigationController(rootViewController: childVc)
        
        addChildViewController(childNav)
    }
}



