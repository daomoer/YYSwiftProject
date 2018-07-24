//
//  U17TodayFooterCell.swift
//  YYSwiftProject
//
//  Created by Domo on 2018/7/23.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit

class U17TodayFooterCell: UITableViewCell {
    private var items:[String] = [String]()

    lazy var picImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.red
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 5
        return imageView
    }()
    
    lazy var button: UIButton = {
        let button = UIButton.init(type: UIButtonType.custom)
        button.backgroundColor = DominantColor
        button.setTitle("阅读漫画", for: UIControlState.normal)
        button.setTitleColor(UIColor.white, for: UIControlState.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 14
        return button
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "球娘"
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    lazy var tagView: UIView = {
        let view = UIView()
        return view
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
    
    func setUpUI(){
        self.addSubview(self.picImageView)
        self.picImageView.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.equalTo(10)
            make.bottom.equalTo(-10)
            make.width.equalTo(100)
        }
        self.addSubview(self.button)
        self.button.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-15)
            make.width.equalTo(85)
            make.height.equalTo(28)
            make.centerY.equalToSuperview()
        }
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(30)
            make.left.equalTo(self.picImageView.snp.right).offset(20)
            make.height.equalTo(30)
            make.right.equalToSuperview()
        }
        
        self.addSubview(self.tagView)
        self.tagView.snp.makeConstraints { (make) in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(5)
            make.height.equalTo(30)
            make.left.equalTo(self.titleLabel.snp.left)
            make.right.equalTo(self.titleLabel.snp.right)
        }
    }
    
    
    var dayComicItem : dayComicItemModel? {
        didSet {
            guard let model = dayComicItem else { return }
            self.picImageView.kf.setImage(with: URL(string:(dayComicItem?.cover)!))
            self.titleLabel.text = model.name
            
            let margin:CGFloat = 35
            items.removeAll()
            items = model.tags as! [String]
            for view in self.tagView.subviews{
                view.removeFromSuperview()
            }
            for index in 0..<items.count{
                let label = UILabel.init(frame: CGRect(x:margin*CGFloat(index)+1*CGFloat(index),y:2.5,width:margin,height:25))
                label.text = nil
                label.textAlignment = .center
//                label.textColor = UIColor.white
//                label.layer.borderColor = UIColor.white.cgColor
//                label.layer.borderWidth = 1
//                label.layer.masksToBounds = true
//                label.layer.cornerRadius = 2
                label.textColor = UIColor.gray
                label.text = items[index]
                label.font = UIFont.systemFont(ofSize: 15)
                self.tagView.addSubview(label)
            }
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
