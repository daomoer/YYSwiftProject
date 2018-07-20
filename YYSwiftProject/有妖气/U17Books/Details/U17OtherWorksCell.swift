//
//  U17OtherWorksCell.swift
//  YYSwiftProject
//
//  Created by Domo on 2018/7/20.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit

class U17OtherWorksCell: UICollectionViewCell {
    lazy var imageView : UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    lazy var updateLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.gray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.imageView)
        self.imageView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-40)
        }
        
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
            make.height.equalTo(20)
            make.top.equalTo(self.imageView.snp.bottom)
        }
        
        self.addSubview(self.updateLabel)
        self.updateLabel.snp.makeConstraints { (make) in
            make.left.right.height.equalTo(self.titleLabel)
            make.top.equalTo(self.titleLabel.snp.bottom)
        }
    }
    
    var model: OtherWorkModel? {
        didSet {
            guard let model = model else { return }
            self.imageView.kf.setImage(with: URL(string:model.coverUrl!))
            self.titleLabel.text = model.name
            self.updateLabel.text = "更新至第\(model.passChapterNum)话"
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
