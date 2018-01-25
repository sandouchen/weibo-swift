//
//  MainViewController.swift
//  weibo-swift
//
//  Created by fqq3 on 2018/1/19.
//  Copyright © 2018年 sandouchan. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {
    
    /// 发布按钮
    private lazy var composeBtn = UIButton(imageName: "tabbar_compose_icon_add", bgImageName: "tabbar_compose_button")

    override func viewDidLoad() {
        super.viewDidLoad()
//        setupTabBarVc()
        
        setupComposeBtn()
    }
}

// MARK: - 设置发布按钮
extension MainViewController {
    /// 设置发布按钮
    private func setupComposeBtn() {
        tabBar.addSubview(composeBtn)
        
        composeBtn.center = CGPoint(x: tabBar.center.x, y: tabBar.bounds.size.height * 0.5)
        
        composeBtn.addTarget(self, action: #selector(MainViewController.composeBtnClick), for: .touchUpInside)
    }
}

// MARK: - 事件监听
extension MainViewController {
    /// 发布按钮点击事件
    @objc private func composeBtnClick() {
        SDLog("composeBtnClick")
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
    private func addChildViewController(childVc: UIViewController, title: String, imageName: String) {
        childVc.title = title
        childVc.tabBarItem.image = UIImage(named: imageName)
        childVc.tabBarItem.selectedImage = UIImage(named: imageName + "_highlighted")
        
        let childNav = UINavigationController(rootViewController: childVc)
        
        addChildViewController(childNav)
    }
}



