//
//  GuideCollectionHeaderView.swift
//  YYSwiftProject
//
//  Created by Domo on 2018/7/19.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit

typealias GuideSorkBtnClick = (_ button: UIButton) -> Void

class GuideCollectionHeaderView: UICollectionReusableView {
     var sorkBtnClick:GuideSorkBtnClick?
    
    lazy var infoLabel : UILabel = {
       let label = UILabel.init()
        label.textColor = UIColor.lightGray
        label.font = UIFont.systemFont(ofSize: 13)
//        label.text = "目录2018-07-19更新 梦魇篇15"
        return label
    }()
    
    lazy var sorkBtn : UIButton = {
        let button = UIButton.init(type: UIButtonType.custom)
         button.setTitle("倒叙", for: UIControlState.normal)
         button.setTitleColor(UIColor.lightGray, for: UIControlState.normal)
         button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
         button.addTarget(self, action: #selector(sorkBtnClick(button:)), for: UIControlEvents.touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.infoLabel)
        self.infoLabel.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.top.equalTo(5)
            make.bottom.equalTo(-5)
            make.right.equalTo(-80)
        }
        self.addSubview(sorkBtn)
        self.sorkBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-10)
            make.width.equalTo(30)
            make.top.equalTo(5)
            make.bottom.equalTo(-5)
        }
    }
    
    @objc func sorkBtnClick(button:UIButton){
        button.isSelected = !button.isSelected
        if button.isSelected {
            button.setTitle("正序", for: UIControlState.normal)
        }else {
            button.setTitle("倒叙", for: UIControlState.normal)
        }
        guard let  sorkBtnClick = sorkBtnClick else { return }
        sorkBtnClick(button)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var model: DetailStaticModel? {
        didSet {
            guard let model = model else { return }
            let format = DateFormatter()
            format.dateFormat = "yyyy-MM-dd"
            infoLabel.text = "目录 \(format.string(from: Date(timeIntervalSince1970: model.comic?.last_update_time ?? 0))) 更新 \(model.chapter_list?.last?.name ?? "")"
        }
    }
}
