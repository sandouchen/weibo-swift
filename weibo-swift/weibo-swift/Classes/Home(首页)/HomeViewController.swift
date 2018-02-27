//
//  HomeViewController.swift
//  weibo-swift
//
//  Created by fqq3 on 2018/1/19.
//  Copyright © 2018年 sandouchan. All rights reserved.
//

import UIKit
import Popover
import SDWebImage
import MJRefresh

class HomeViewController: BaseViewController {
    
    /// 懒加载 titleView 按钮
    private lazy var titleBtn = UIButton()
    
    /// 懒加载 popoverTableView
    private lazy var popoverTableView = UITableView()
    
    private lazy var viewModels: [StatusViewModel] = [StatusViewModel]()
    
    private lazy var tipLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // 访客页面动画
        visitorView.addRotationAnim()
        
        if !isLogin { return }
        
        // 初始化导航栏按钮
        setupNavigationBar()
        
        // 设定 tableView 自适应高度
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        
        // 创建headerView
        setupHeaderView()
        // 创建headerView
        setupFooterView()
        
        // 设置提示的Label
        setupTipLabel()
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
        titleBtn.set(imageName: UIImage(named: "navigationbar_arrow_down"), title: (UserAccountTool.shareInstance.account?.screen_name)!, titlePosition: .left, additionalSpacing: 8, state: .normal)
        titleBtn.set(imageName: UIImage(named: "navigationbar_arrow_up"), title: (UserAccountTool.shareInstance.account?.screen_name)!, titlePosition: .left, additionalSpacing: 8, state: .selected)
        titleBtn.sizeToFit()
        titleBtn.adjustsImageWhenHighlighted = false
        navigationItem.titleView = titleBtn
    }
    
    /// 创建headerView
    private func setupHeaderView() {
        let header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(HomeViewController.loadNewStatuses))
        
        header?.setTitle("下拉刷新", for: .idle)
        header?.setTitle("可以松手", for: .pulling)
        header?.setTitle("正在刷新", for: .refreshing)
        
        tableView.mj_header = header
        tableView.mj_header.beginRefreshing()
    }
    
    /// 创建footerView
    private func setupFooterView() {
        tableView.mj_footer = MJRefreshAutoFooter(refreshingTarget: self, refreshingAction: #selector(HomeViewController.loadMoreStatuses))
    }

    private func setupTipLabel() {
        navigationController?.navigationBar.insertSubview(tipLabel, at: 0)
        
        tipLabel.frame = CGRect(x: 0, y: 14, width: UIScreen.main.bounds.width, height: 30)
        
        tipLabel.backgroundColor = mainColor
        tipLabel.textColor = .white
        tipLabel.textAlignment = .center
        tipLabel.font = UIFont.systemFont(ofSize: 14)
        tipLabel.alpha = 0.0
        tipLabel.isHidden = true
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
//        popoverTableView.dataSource = self
//        popoverTableView.delegate = self
        
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

// MARK: - 请求数据
extension HomeViewController {
    /// 下拉加载最新的数据
    @objc private func loadNewStatuses() {
        loadStatuses(isNewData: true)
    }
    
    /// 上拉加载最新的数据
    @objc private func loadMoreStatuses() {
        loadStatuses(isNewData: false)
    }
    
    /// 请求数据
    private func loadStatuses(isNewData: Bool) {
        // 获取since_id / max_id
        var since_id = 0
        var max_id = 0
        
        if isNewData {
            since_id = viewModels.first?.status?.mid ?? 0
        } else {
            max_id = viewModels.last?.status?.mid ?? 0
            max_id = max_id == 0 ? 0 : (max_id - 1)
        }
        
        
        NetWorkTools.shareInstance.loadNewWeiBo(since_id: since_id, max_id: max_id) { (result, error) in
            if error != nil {
                SDLog(error)
                return
            }
            
            guard let resultArray = result else {
                SDLog("没有数据")
                return
            }
            
            var tempViewModel = [StatusViewModel]()
            
            for statusDict in resultArray {
                let status = StatusModel(dict: statusDict)
                let viewModel = StatusViewModel(status: status)
                
                tempViewModel.append(viewModel)
            }
            
            if isNewData {
                self.viewModels = tempViewModel + self.viewModels
            } else {
                self.viewModels += tempViewModel
            }
            
            self.cacheImages(viewModels: tempViewModel)
        }
    }
    
    /// 缓存图片
    private func cacheImages(viewModels : [StatusViewModel]) {
        // 0.创建group
        let group = DispatchGroup()
        
        // 1.缓存图片
        for viewModel in viewModels {
            for picURL in viewModel.picURLs {
                group.enter()
                
                SDWebImageManager.shared().imageDownloader?.downloadImage(with: picURL, options: [], progress: nil, completed: { (_, _, _, _) in
                    
                    group.leave()
                })
            }
        }
        
        // 2.刷新表格
        group.notify(queue: DispatchQueue.main) {
            self.tableView.reloadData()
            self.tableView.mj_header.endRefreshing()
            self.tableView.mj_footer.endRefreshing()
            
            // 显示提示的Label
            self.showTipLabel(count: viewModels.count)
        }
    }

    /// 显示提示的Label
    private func showTipLabel(count : Int) {
        tipLabel.text = count == 0 ? "没有新数据" : "\(count) 条形微博"
        
        UIView .animate(withDuration: 1.0, animations: {
            self.tipLabel.frame.origin.y = 44
            self.tipLabel.isHidden = false
            self.tipLabel.alpha = 1.0
            
        }) { (_) in
            UIView .animate(withDuration: 1.0, delay: 1.5, options: [], animations: {
                self.tipLabel.frame.origin.y = 14
                self.tipLabel.alpha = 0.0
                
            }, completion: { (_) in
                self.tipLabel.isHidden = true
                
            })
        }
    }
}

// MARK: - tableView 的数据源与代理
extension HomeViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModels.count
    }
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell") as! HomeViewCell
        
            cell.viewModel = viewModels[indexPath.row]
            return cell
     }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        SDLog("点击了第 \(indexPath.row) 行")
    }
}


