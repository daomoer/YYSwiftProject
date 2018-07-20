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
        self.picView.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.top.equalTo(10)
            make.left.equalTo(10)
            make.bottom.equalTo(-10)
        }
        
        self.addSubview(self.mainTitle)
        self.mainTitle.font = UIFont.systemFont(ofSize: 16)
        self.mainTitle.snp.makeConstraints { (make) in
            make.height.equalTo(20)
            make.left.equalTo(self.picView.snp.right).offset(10)
            make.top.equalTo(10)
            make.right.equalTo(-10)
        }
        
        self.addSubview(self.subTitle)
        self.subTitle.font = UIFont.systemFont(ofSize: 13)
        self.subTitle.textColor = UIColor.gray
        self.subTitle.snp.makeConstraints { (make) in
            make.left.equalTo(self.mainTitle.snp.left)
            make.top.equalTo(self.mainTitle.snp.bottom).offset(10)
            make.height.equalTo(20)
            make.right.equalTo(self.mainTitle.snp.right)
        }
        
        self.addSubview(self.desLabel)
        self.desLabel.numberOfLines = 0
        self.desLabel.textColor = UIColor.gray
        self.desLabel.font = UIFont.systemFont(ofSize: 13)
        self.desLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.subTitle.snp.left)
            make.top.equalTo(self.subTitle.snp.bottom).offset(10)
            make.right.equalTo(self.subTitle.snp.right)
            make.bottom.equalTo(self).offset(-30)
        }
        
        self.addSubview(self.headLabel)
        self.headLabel.font = UIFont.systemFont(ofSize: 13)
        self.headLabel.textColor = UIColor.orange
        self.headLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.desLabel.snp.left)
            make.width.equalTo(150)
            make.top.equalTo(self.desLabel.snp.bottom).offset(10)
            make.bottom.equalTo(self).offset(-10)
        }
        
        self.addSubview(self.rankImage)
        self.rankImage.snp.makeConstraints { (make) in
            make.width.equalTo(30)
            make.height.equalTo(25)
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
  // 分不同的类型，headLabel是显示热度
    var model: ComicModel? {
        didSet {
            guard let model = model else { return }
            self.picView.kf.setImage(with: URL(string:model.cover!))
            self.desLabel.text = model.description
            self.mainTitle.text = model.name
            var tagStr: String = ""
            for tag in model.tags!{
                tagStr = String(format:"%@ | %@",tag,tagStr)
            }
            self.subTitle.text = String(format:"%@%@",tagStr,model.author!)
            let head = model.conTag
            self.headLabel.text = "热度\(head)"
        }
    }
    
    var indexPath: IndexPath? {
        didSet {
            guard let indexPath = indexPath else { return }
            switch indexPath.row {
            case 0:
                self.rankImage.image = UIImage(named:"rank_frist")
            case 1:
                self.rankImage.image = UIImage(named:"rank_second")
            case 2:
                self.rankImage.image = UIImage(named:"rank_third")
            default:
                self.rankImage.image = nil
                break
            }
        }
    }
    
    // 分不同的类型，headLabel是显示更新时间
    var updateModel: ComicModel? {
        didSet {
            guard let model = updateModel else { return }
            self.picView.kf.setImage(with: URL(string:model.cover!))
            self.desLabel.text = model.description
            self.mainTitle.text = model.name
            var tagStr: String = ""
            for tag in model.tags!{
                tagStr = String(format:"%@ | %@",tag,tagStr)
            }
            self.subTitle.text = String(format:"%@%@",tagStr,model.author!)
        }
    }
    
    var spinnerName : String? {
        didSet {
            guard let conTag = self.updateModel?.conTag else { return }
            if spinnerName == "更新时间" {
                let comicDate = Date().timeIntervalSince(Date(timeIntervalSince1970: TimeInterval(conTag)))
                var tagString = ""
                if comicDate < 60 {
                    tagString = "\(Int(comicDate))秒前"
                } else if comicDate < 3600 {
                    tagString = "\(Int(comicDate / 60))分前"
                } else if comicDate < 86400 {
                    tagString = "\(Int(comicDate / 3600))小时前"
                } else if comicDate < 31536000{
                    tagString = "\(Int(comicDate / 86400))天前"
                } else {
                    tagString = "\(Int(comicDate / 31536000))年前"
                }
                self.headLabel.text = "更新时间\(tagString)"
            }else {
                let spinnerStr:String = spinnerName!
                var tagString = ""
                if conTag > 100000000 {
                    tagString = String(format: "%.1f亿", Double(conTag) / 100000000)
                } else if conTag > 10000 {
                    tagString = String(format: "%.1f万", Double(conTag) / 10000)
                } else {
                    tagString = "\(conTag)"
                }
                if tagString != "0" {
                    self.headLabel.text = "\(spinnerStr)\(tagString)"
                }
//            }else if spinnerName == "收藏量" {
//
            }
        }
    }
}
