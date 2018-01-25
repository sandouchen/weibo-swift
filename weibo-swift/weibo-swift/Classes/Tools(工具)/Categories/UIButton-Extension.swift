//
//  UIButton-Extension.swift
//  weibo-swift
//
//  Created by fqq3 on 2018/1/23.
//  Copyright © 2018年 sandouchan. All rights reserved.
//

import UIKit

extension UIButton {
    /// 快速创建 UIButton
    convenience init(imageName: String, bgImageName: String) {
        self.init()
        
        setBackgroundImage(UIImage(named: bgImageName), for: .normal)
        setBackgroundImage(UIImage(named: bgImageName + "_highlighted"), for: .highlighted)
        
        setImage(UIImage(named: imageName), for: .normal)
        setImage(UIImage(named: imageName + "_highlighted"), for: .highlighted)
        
        sizeToFit()
    }
    
    /// 自定义按钮图片与文字位置
    @objc func set(imageName: UIImage?, title: String, titlePosition: UIViewContentMode, additionalSpacing: CGFloat, state: UIControlState) {
        imageView?.contentMode = .center
        setImage(imageName, for: state)
        
        positionLabelRespectToImage(title: title, position: titlePosition, spacing: additionalSpacing)
        
        titleLabel?.contentMode = .center
        setTitle(title, for: state)
    }
    
    private func positionLabelRespectToImage(title: String, position: UIViewContentMode, spacing: CGFloat) {
        let imageSize = imageRect(forContentRect: frame)
        let titleFont = titleLabel?.font!
        let titleSize = title.size(withAttributes: [NSAttributedStringKey.font: titleFont!])
        
        var titleInsets: UIEdgeInsets
        var imageInsets: UIEdgeInsets
        
        switch (position) {
        case .top:
            titleInsets = UIEdgeInsets(top: -(imageSize.height + titleSize.height + spacing),
                                       left: -(imageSize.width), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -titleSize.width)
        case .bottom:
            titleInsets = UIEdgeInsets(top: (imageSize.height + titleSize.height + spacing),
                                       left: -(imageSize.width), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -titleSize.width)
        case .left:
            titleInsets = UIEdgeInsets(top: 0, left: -(imageSize.width * 2), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0,
                                       right: -(titleSize.width * 2 + spacing))
        case .right:
            titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -spacing)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        default:
            titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        
        titleEdgeInsets = titleInsets
        imageEdgeInsets = imageInsets
    }
}




