//
//  ComposeTextView.swift
//  weibo-swift
//
//  Created by fqq3 on 2018/2/7.
//  Copyright © 2018年 sandouchan. All rights reserved.
//

import UIKit
import SnapKit

class ComposeTextView: UITextView {
    /// 占位文字 Label
    lazy var placeHolderLabel : UILabel = UILabel()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    
}

// MARK:- 设置UI界面
extension ComposeTextView {
    /// 设置UI界面
    private func setupUI() {
        addSubview(placeHolderLabel)
        
        placeHolderLabel.snp.makeConstraints { (make) in
            make.left.equalTo(13)
            make.top.equalTo(6)
        }
        
        // 3.设置placeholderLabel属性
        placeHolderLabel.textColor = .lightGray
        placeHolderLabel.font = font
        
        // 4.设置placeholderLabel文字
        placeHolderLabel.text = "分享新鲜事..."
        
        textContainerInset = UIEdgeInsets(top: 6, left: 7, bottom: 0, right: 7)
    }
}










