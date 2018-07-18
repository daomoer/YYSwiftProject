//
//  U17YTDRankCell.swift
//  YYSwiftProject
//
//  Created by Domo on 2018/7/17.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit

class U17YTDRankCell: UITableViewCell {
    lazy var picView = UIImageView()
    lazy var mainTitle = UILabel()
    lazy var subTitle = UILabel()
    lazy var desLabel = UILabel()
    lazy var headLabel = UILabel()
    lazy var rankImage = UIImageView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
    
    func setUpUI(){
        self.addSubview(self.picView)
        self.picView.image = UIImage(named:"pic1.jpeg")
        self.picView.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.top.equalTo(10)
            make.left.equalTo(10)
            make.bottom.equalTo(-10)
        }
        
        self.addSubview(self.mainTitle)
        self.mainTitle.text = "镇魂街"
        self.mainTitle.font = UIFont.systemFont(ofSize: 16)
        self.mainTitle.snp.makeConstraints { (make) in
            make.height.equalTo(20)
            make.left.equalTo(self.picView.snp.right).offset(10)
            make.top.equalTo(10)
            make.right.equalTo(-10)
        }
        
        self.addSubview(self.subTitle)
        self.subTitle.text = "魔幻|许晨"
        self.subTitle.font = UIFont.systemFont(ofSize: 13)
        self.subTitle.textColor = UIColor.lightGray
        self.subTitle.snp.makeConstraints { (make) in
            make.left.equalTo(self.mainTitle.snp.left)
            make.top.equalTo(self.mainTitle.snp.bottom).offset(10)
            make.height.equalTo(20)
            make.right.equalTo(self.mainTitle.snp.right)
        }
        
        self.addSubview(self.desLabel)
        self.desLabel.text = "都是雷锋精神的陆丰邻居啥的发牢骚的经费落实到来健身房时代峻峰伞带来邻居啥的雷锋精神的发蓝色的了即第三方接收到陆丰邻居啥的发牢骚的两家都是俯拾地芥"
        self.desLabel.numberOfLines = 0
        self.desLabel.textColor = UIColor.lightGray
        self.desLabel.font = UIFont.systemFont(ofSize: 13)
        self.desLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.subTitle.snp.left)
            make.top.equalTo(self.subTitle.snp.bottom).offset(10)
            make.right.equalTo(self.subTitle.snp.right)
            make.bottom.equalTo(self).offset(-30)
        }
        
        self.addSubview(self.headLabel)
        self.headLabel.text = "热度 350万"
        self.headLabel.font = UIFont.systemFont(ofSize: 13)
        self.headLabel.textColor = UIColor.orange
        self.headLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.desLabel.snp.left)
            make.width.equalTo(100)
            make.top.equalTo(self.desLabel.snp.bottom).offset(10)
            make.bottom.equalTo(self).offset(-10)
        }
        
        self.addSubview(self.rankImage)
        self.rankImage.image = UIImage(named:"pic3.jpeg")
        self.rankImage.snp.makeConstraints { (make) in
            make.width.height.equalTo(25)
            make.right.equalTo(self).offset(-10)
            make.bottom.equalTo(self).offset(-10)
        }
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
