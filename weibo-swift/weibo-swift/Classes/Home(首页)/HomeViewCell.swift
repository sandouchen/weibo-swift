//
//  HomeViewCell.swift
//  weibo-swift
//
//  Created by fqq3 on 2018/2/1.
//  Copyright © 2018年 sandouchan. All rights reserved.
// 07 获取转发数据

import UIKit
import SDWebImage

private let edgeMargin : CGFloat = 10
private let itemMargin : CGFloat = 3

class HomeViewCell: UITableViewCell {
    // MARK:- 控件属性
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var verifiedView: UIImageView!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var vipView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var picView: PicCollectionView!
    @IBOutlet weak var retweetedContentLabel: UILabel!
    @IBOutlet weak var retweetedBgView: UIView!
    
    // MARK:- 约束的属性
    @IBOutlet weak var picViewHCons: NSLayoutConstraint!
    @IBOutlet weak var picViewWCons: NSLayoutConstraint!
    @IBOutlet weak var picViewBottomCons: NSLayoutConstraint!
    @IBOutlet weak var retweetedContentLabelTopCons: NSLayoutConstraint!
    
    var viewModel: StatusViewModel? {
        didSet {
            // 1.nil值校验
            guard let viewModel = viewModel else { return }
            
            // 2.设置头像
            iconView.sd_setImage(with: viewModel.profileURL, placeholderImage: UIImage(named: "avatar_default_small"))
            
            // 3.设置认证的图标
            verifiedView.image = viewModel.verifiedImage
            
            // 4.昵称
            screenNameLabel.text = viewModel.status?.user?.screen_name
            
            // 5.会员图标
            vipView.image = viewModel.vipImage
            
            // 6.设置时间的Label
            timeLabel.text = viewModel.createdAtStr
            
            // 7.设置微博正文
            contentLabel.text = viewModel.status?.text
            
            // 8.设置来源
            if let sourceText = viewModel.sourceText {
                sourceLabel.text = "来自 " + sourceText
            } else {
                sourceLabel.text = nil
            }
            
            // 9.设置昵称的文字颜色
            screenNameLabel.textColor = viewModel.vipImage == nil ? .black : mainColor
            
            // 10.计算picView的宽度和高度的约束
            let picViewSize = calculatePicViewSize(count: viewModel.picURLs.count)
            picViewWCons.constant = picViewSize.width
            picViewHCons.constant = picViewSize.height
            
            // 11.将picURL数据传递给picView
            picView.picURLs = viewModel.picURLs
            
            // 12.设置转发微博的正文
            if viewModel.status?.retweeted_status != nil {
                if let screenName = viewModel.status?.retweeted_status?.user?.screen_name, let retweetedText = viewModel.status?.retweeted_status?.text {
                    retweetedContentLabel.text = "@" + "\(screenName): " + retweetedText
                    
                    // 设置转发正文距离顶部的约束
                    retweetedContentLabelTopCons.constant = 15
                }
                
                retweetedBgView.isHidden = false
            } else {
                retweetedContentLabel.text = nil
                retweetedContentLabelTopCons.constant = 0
                retweetedBgView.isHidden = true
            }
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}

// MARK:- 计算方法
extension HomeViewCell {
    private func calculatePicViewSize(count : Int) -> CGSize {
        // 1.没有配图
        if count == 0 {
            picViewBottomCons.constant = 0
            return CGSize.zero
        }
        
        // 有配图需要改约束有值
        picViewBottomCons.constant = 10
        
        // 2.取出picView对应的layout
        let layout = picView.collectionViewLayout as! UICollectionViewFlowLayout
        
        // 3.单张配图
        if count == 1 {
            // 1.取出图片
            let urlStr = viewModel?.picURLs.last?.absoluteString

            let image = SDWebImageManager.shared().imageCache?.imageFromDiskCache(forKey: urlStr)
            
            if let image = image {
                layout.itemSize = CGSize(width: image.size.width * 2, height: image.size.height * 2)
                
                return layout.itemSize
            }
        }
        
        // 4.计算出来imageViewWH
        let imageViewWH = (UIScreen.main.bounds.width - 2 * edgeMargin - 2 * itemMargin) / 3
        
        // 5.设置其他张图片时layout的itemSize
        layout.itemSize = CGSize(width: imageViewWH, height: imageViewWH)
        
        // 6.四张配图
        if count == 4 {
            let picViewWH = imageViewWH * 2 + itemMargin
            
            return CGSize(width: picViewWH, height: picViewWH)
        }
        
        // 7.其他张配图
        // 7.1.计算行数
        let rows = CGFloat((count - 1) / 3 + 1)
        
        // 7.2.计算picView的高度
        let picViewH = rows * imageViewWH + (rows - 1) * itemMargin
        
        // 7.3.计算picView的宽度
        let picViewW = UIScreen.main.bounds.width - 2 * edgeMargin
        
        return CGSize(width: picViewW, height: picViewH)
    }
}










