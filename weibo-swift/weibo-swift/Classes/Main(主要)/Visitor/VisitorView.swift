//
//  VisitorView.swift
//  weibo-swift
//
//  Created by fqq3 on 2018/1/23.
//  Copyright © 2018年 sandouchan. All rights reserved.
//

import UIKit

class VisitorView: UIView {
    @IBOutlet weak var rotationView: UIImageView!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    
    class func visitorView() -> VisitorView {
        return Bundle.main.loadNibNamed("VisitorView", owner: nil, options: nil)?.first! as! VisitorView
    }
    
    func setupVisitorViewInfo(iconName: String, tipTitle: String) {
        iconView.image = UIImage(named: iconName)
        tipLabel.text = tipTitle
        rotationView.isHidden = true
    }
    
    func addRotationAnim() {
        let rotationAnim = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnim.toValue = Double.pi * 2
        rotationAnim.repeatCount = MAXFLOAT
        rotationAnim.duration = 5
        rotationAnim.isRemovedOnCompletion = false
        rotationView.layer.add(rotationAnim, forKey: nil)
    }
}

