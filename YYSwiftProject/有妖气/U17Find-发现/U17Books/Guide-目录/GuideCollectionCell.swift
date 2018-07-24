//
//  GuideCollectionCell.swift
//  YYSwiftProject
//
//  Created by Domo on 2018/7/19.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit

class GuideCollectionCell: UICollectionViewCell {
    lazy var nameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5.0
        label.layer.borderColor = UIColor.lightGray.cgColor
        label.layer.borderWidth = 1
        label.textColor = UIColor.black
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.nameLabel)
        self.nameLabel.snp.makeConstraints { (make) in
            make.width.height.equalToSuperview()
            make.center.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var chapterStatic: ChapterStaticModel? {
        didSet {
            guard let chapterStatic = chapterStatic else { return }
            let str : String = "  "
            nameLabel.text = str + chapterStatic.name!
        }
    }
}
