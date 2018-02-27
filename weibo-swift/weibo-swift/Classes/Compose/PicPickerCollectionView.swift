//
//  PicPickerCollectionView.swift
//  weibo-swift
//
//  Created by fqq3 on 2018/2/7.
//  Copyright © 2018年 sandouchan. All rights reserved.
//

import UIKit

private let picPickerItem = "picPickerCell"
private let edgeMargin : CGFloat = 10

class PicPickerCollectionView: UICollectionView {
    var images = [UIImage]() {
        didSet{
            reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        dataSource = self
        
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        
        let itemWH = (UIScreen.main.bounds.width - 4 * edgeMargin) / 3
        
        layout.itemSize = CGSize(width: itemWH, height: itemWH)
        
        register(UINib(nibName: "PicPickerViewCell", bundle: nil), forCellWithReuseIdentifier: picPickerItem)
        
        // 设置collectionView的内边距
        contentInset = UIEdgeInsets(top: edgeMargin, left: edgeMargin, bottom: 0, right: edgeMargin)
    }
}

extension PicPickerCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: picPickerItem, for: indexPath) as! PicPickerViewCell
        
        item.image = indexPath.item <= images.count - 1 ? images[indexPath.item] : nil
        
        return item
    }
}
