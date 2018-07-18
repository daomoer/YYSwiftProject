//
//  AlcrossRecommendCell.swift
//  YYSwiftProject
//
//  Created by Domo on 2018/7/17.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit

class AlcrossRecommendCell: UICollectionViewCell {
    @IBOutlet weak var picImage: UIImageView!
    @IBOutlet weak var mainTitleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var model: ComicModel? {
        didSet {
            guard let model = model else { return }
            picImage.kf.setImage(with: URL(string : model.cover!))
            mainTitleLabel.text = model.name ?? model.title
            subTitleLabel.text = model.subTitle ?? "更新至\(model.content ?? "0")集"
        }
    }

}
