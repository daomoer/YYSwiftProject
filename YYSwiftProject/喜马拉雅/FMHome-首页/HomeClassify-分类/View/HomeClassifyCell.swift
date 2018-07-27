//
//  HomeClassifyCell.swift
//  YYSwiftProject
//
//  Created by Domo on 2018/7/24.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit

class HomeClassifyCell: UICollectionViewCell {
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    lazy var titleLabel : UILabel = {
       let label = UILabel()
//        label.text = "啦啦啦"
//        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.imageView)
        self.imageView.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.width.height.equalTo(28)
            make.centerY.equalToSuperview()
        }
        
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.imageView.snp.right).offset(5)
            make.top.bottom.equalTo(self.imageView)
            make.width.equalToSuperview().offset(-self.imageView.frame.width)
        }
    }
    
    var itemModel:ItemList? {
        didSet {
            guard let model = itemModel else { return }
            if model.itemType == 1 {// 如果是第一个item,是有图片显示的，并且字体偏小
                self.titleLabel.text = model.itemDetail?.keywordName
            }else{
                self.titleLabel.text = model.itemDetail?.title
                self.imageView.kf.setImage(with: URL(string: model.coverPath!))
            }
        }
    }
    
    // 前三个分区第一个item的字体较小
//    var indexPath: IndexPath? {
//        didSet {
//            guard let indexPath = indexPath else { return }
//            
//        }
//    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

