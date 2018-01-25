//
//  HomeViewController.swift
//  weibo-swift
//
//  Created by fqq3 on 2018/1/19.
//  Copyright © 2018年 sandouchan. All rights reserved.
//

import UIKit
import Popover

class HomeViewController: BaseViewController {
    
    /// 懒加载 titleView 按钮
    lazy var titleBtn = UIButton()
    
    /// 懒加载 popoverTableView
    lazy var popoverTableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // 访客页面动画
        visitorView.addRotationAnim()
        
        // 初始化导航栏按钮
        setupNavigationBar()
        
    }
    

}

// MARK: - 设置 UI 界面
extension HomeViewController {
    /// 设置导航栏按钮
    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_friendattention", target: self, action: #selector(HomeViewController.leftBtnClick))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "navigationbar_pop", target: self, action: #selector(HomeViewController.rightBtnClick))
        
        // 设置 titleView 按钮
        titleBtn.setTitleColor(.black, for: .normal)
        titleBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        titleBtn.addTarget(self, action: #selector(HomeViewController.titleBtnClick), for: .touchUpInside)
        titleBtn.set(imageName: UIImage(named: "navigationbar_arrow_down"), title: "sandou", titlePosition: .left, additionalSpacing: 8, state: .normal)
        titleBtn.set(imageName: UIImage(named: "navigationbar_arrow_up"), title: "sandou", titlePosition: .left, additionalSpacing: 8, state: .selected)
        titleBtn.sizeToFit()
        titleBtn.adjustsImageWhenHighlighted = false
        navigationItem.titleView = titleBtn
    }
}

// MARK: - 事件监听
extension HomeViewController {
    /// 注册按钮点击事件
    @objc private func leftBtnClick() {
        SDLog("leftBtnClick")
    }
    
    /// 登陆按钮点击事件
    @objc private func rightBtnClick() {
        SDLog("rightBtnClick")
    }
    
    /// titleView按钮点击事件
    @objc private func titleBtnClick(titleBtn: UIButton) {
        titleViewAnimation(fromValue: 0, toValue: Double.pi)
        
        let width = view.bounds.width * 0.4
        popoverTableView.frame = CGRect(x: 0, y: 0, width: width, height: width + 30)
        popoverTableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0)
        popoverTableView.scrollIndicatorInsets = popoverTableView.contentInset
        popoverTableView.dataSource = self
        popoverTableView.delegate = self
        
        let popoverView = Popover(options: nil, showHandler: nil)
        popoverView.popoverColor = UIColor(red: 76/255, green: 76/255, blue: 76/255, alpha: 1)
        popoverView.blackOverlayColor = .clear
        
        popoverView.willDismissHandler = {
            self.titleViewAnimation(fromValue: Double.pi, toValue: Double.pi * 2)
        }
        
        popoverView.show(popoverTableView, fromView: titleBtn)
    }
}

// MARK: - titleView 动画事件
extension HomeViewController {
    /// titleView 动画事件
    private func titleViewAnimation(fromValue: Any?, toValue: Any?) {
        let anima = CABasicAnimation(keyPath: "transform.rotation.z")
        anima.fromValue = fromValue
        anima.toValue = toValue
        anima.duration = 0.3
        anima.repeatCount = 1
        anima.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        anima.isRemovedOnCompletion = false
        anima.fillMode = kCAFillModeForwards
        titleBtn.imageView?.layer.add(anima, forKey: nil)
    }
}

// MARK: - tableView 的数据源与代理
extension HomeViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == popoverTableView {
            return 5
        }
        
        return 50
    }
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == popoverTableView {
            let popoverCell = "popoverCell"
            
            var cell = tableView.dequeueReusableCell(withIdentifier: popoverCell)
            
            if cell == nil {
                cell = UITableViewCell(style: .default, reuseIdentifier: popoverCell)
            }
            
            cell?.selectionStyle = .none
            cell?.backgroundColor = .clear
            cell?.textLabel?.textColor = .white
            cell?.textLabel?.text = "数据 \(indexPath.row)"
            
            return cell!
            
        } else {
            let homeCell = "homeCell"
            
            let cell = tableView.dequeueReusableCell(withIdentifier: homeCell)
            
            cell?.textLabel?.text = "数据 \(indexPath.row)"
            
            return cell!
        }
     }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == popoverTableView {
            SDLog("点击了第 \(indexPath.row) 行")
        } else {
            tableView.deselectRow(at: indexPath, animated: true)
            SDLog("点击了第 \(indexPath.row) 行")
        }
    }
}


