//
//  U17RecommendTopicCell.swift
//  YYSwiftProject
//
//  Created by Domo on 2018/7/17.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit

class U17RecommendTopicCell: UICollectionViewCell {

    @IBOutlet weak var picImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var model: ComicModel? {
        didSet {
            guard let model = model else { return }
            picImage.kf.setImage(with: URL(string : model.cover!))
        }
    }

}
