//
//  ComposeTitleView.swift
//  weibo-swift
//
//  Created by fqq3 on 2018/2/6.
//  Copyright © 2018年 sandouchan. All rights reserved.
//

import UIKit

class ComposeTitleView: UIView {
    @IBOutlet weak var screenNameLabel: UILabel!
    
    class func composeTitleView() -> ComposeTitleView {
        return Bundle.main.loadNibNamed("ComposeTitleView", owner: nil, options: nil)?.first as! ComposeTitleView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        screenNameLabel.text = UserAccountTool.shareInstance.account?.screen_name
    }
    
}
