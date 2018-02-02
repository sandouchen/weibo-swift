//
//  PicCollectionView.swift
//  weibo-swift
//
//  Created by fqq3 on 2018/2/1.
//  Copyright © 2018年 sandouchan. All rights reserved.
//

import UIKit

class PicCollectionView: UICollectionView {
    // MARK:- 定义属性
    var picURLs : [URL] = [URL]() {
        didSet {
            self.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        dataSource = self
    }
}

extension PicCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return picURLs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PicCell", for: indexPath) as! PicCollectionViewCell
        
        cell.picURL = picURLs[indexPath.item]
        
        return cell
    }
}

class PicCollectionViewCell : UICollectionViewCell {
    
    var picURL: URL? {
        didSet{
            guard let picURL = picURL else { return }
            
            iconVIew.sd_setImage(with: picURL, placeholderImage: UIImage(named: "empty_picture"))
        }
    }
    
    @IBOutlet weak var iconVIew: UIImageView!
    
}


