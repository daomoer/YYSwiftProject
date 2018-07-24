//
//  U17ReadCell.swift
//  YYSwiftProject
//
//  Created by Domo on 2018/7/21.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit

class U17ReadCell: UICollectionViewCell {
    lazy var imageView : UIImageView = {
       let imageView = UIImageView()
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.imageView)
        self.imageView.snp.makeConstraints { (make) in
            make.width.height.equalToSuperview()
            make.center.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var model: ImageModel? {
        didSet { 
            guard let model = model else { return }
            self.imageView.kf.setImage(with: URL(string:model.location!))
        }
    }
    
}
