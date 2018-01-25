//
//  BaseViewController.swift
//  weibo-swift
//
//  Created by fqq3 on 2018/1/23.
//  Copyright © 2018年 sandouchan. All rights reserved.
//

import UIKit

class BaseViewController: UITableViewController {
    
    /// 访客界面 View
    lazy var visitorView = VisitorView.visitorView()
    
    var isLogin = true
    
    override func loadView() {
        isLogin ? super.loadView() : setupVisitorView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItems()
    }

}

// MARK: - 初始化访客界面
extension BaseViewController {
    /// 初始化访客界面
    private func setupVisitorView() {
        view = visitorView
        
        visitorView.registerBtn.addTarget(self, action: #selector(BaseViewController.registerBtnClick), for: .touchUpInside)
        visitorView.loginBtn.addTarget(self, action: #selector(BaseViewController.loginBtnClick), for: .touchUpInside)
    }
    
    ///  设置导航栏按钮
    private func setupNavigationItems() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: .plain, target: self, action: #selector(BaseViewController.registerBtnClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登陆", style: .plain, target: self, action: #selector(BaseViewController.loginBtnClick))
    }
}

// MARK: - 事件监听
extension BaseViewController {
    /// 注册按钮点击事件
    @objc private func registerBtnClick() {
        SDLog("registerBtnClick")
    }
    
    /// 登陆按钮点击事件
    @objc private func loginBtnClick() {
        SDLog("loginBtnClick")
    }
}




