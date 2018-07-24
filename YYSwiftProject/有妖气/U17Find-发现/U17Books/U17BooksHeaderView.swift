//
//  U17BooksHeaderView.swift
//  YYSwiftProject
//
//  Created by Domo on 2018/7/19.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit

class U17BooksHeaderView: UIView {
    lazy var imageView = UIImageView()
    lazy var titleLabel = UILabel()
    lazy var authorLabel = UILabel()
    lazy var clickAndCollectL = UILabel()
    lazy var bgView = UIView()
    lazy var classifyView = UIView()
    lazy var blurImageView = UIImageView()

    private var items:[String] = [String]()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    func setUpUI(){
        self.addSubview(self.bgView)
        self.blurImageView = UIImageView.init(frame:  CGRect(x:0 , y:0 , width: YYScreenWidth , height: self.frame.height))
//        self.blurImageView.image = UIImage(named: "pic2.jpeg")
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light)) as UIVisualEffectView
        visualEffectView.frame = self.blurImageView.bounds
        //        //添加毛玻璃效果层
        self.blurImageView.addSubview(visualEffectView)
        self.insertSubview(self.blurImageView, belowSubview: self.bgView)
        self.bgView.snp.makeConstraints { (make) in
            make.width.height.equalTo(self)
            make.center.equalTo(self)
        }
        
        self.addSubview(self.imageView)
//        self.imageView.image = UIImage(named:"pic2.jpeg")
        self.imageView.layer.masksToBounds = true
        self.imageView.layer.cornerRadius = 5
        self.imageView.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(64+10)
            make.bottom.equalTo(-20)
            make.width.equalTo(120)
        }
        
        self.addSubview(self.titleLabel)
//        self.titleLabel.text = "长安妖歌"
        self.titleLabel.textColor = UIColor.white
        self.titleLabel.font = UIFont.systemFont(ofSize: 16)
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.imageView.snp.right).offset(15)
            make.height.equalTo(20)
            make.right.equalTo(-15)
            make.top.equalTo(self.imageView.snp.top)
        }
        
        self.addSubview(self.authorLabel)
//        self.authorLabel.text = "薛红石"
        self.authorLabel.textColor = UIColor.white
        self.authorLabel.font = UIFont.systemFont(ofSize: 13)
        self.authorLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.titleLabel.snp.left)
            make.height.equalTo(self.titleLabel.snp.height)
            make.right.equalTo(self.titleLabel.snp.right)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(10)
        }
        
        self.addSubview(self.clickAndCollectL)
//        self.clickAndCollectL.text = "点击960.2万 收藏455.9万"
        self.clickAndCollectL.font = UIFont.systemFont(ofSize: 13)
        self.clickAndCollectL.textColor = UIColor.white
        self.clickAndCollectL.snp.makeConstraints { (make) in
            make.left.equalTo(self.authorLabel.snp.left)
            make.height.equalTo(self.authorLabel.snp.height)
            make.right.equalTo(self.authorLabel.snp.right)
            make.top.equalTo(self.authorLabel.snp.bottom).offset(15)
        }
    
        self.addSubview(self.classifyView)
        self.classifyView.snp.makeConstraints { (make) in
            make.left.equalTo(self.clickAndCollectL.snp.left)
            make.right.equalTo(self.clickAndCollectL.snp.right)
            make.height.equalTo(30)
            make.bottom.equalTo(self.imageView.snp.bottom).offset(-10)
        }
    }
    
    
    var detailStatic: ComicStaticModel? {
        didSet {
            guard let detailStatic = detailStatic else { return }
            self.blurImageView.kf.setImage(with: URL(string:detailStatic.cover!))
            self.imageView.kf.setImage(with: URL(string:detailStatic.cover!))
            self.titleLabel.text = detailStatic.name
            self.authorLabel.text = detailStatic.author?.name
            
            let margin:CGFloat = 40
            items.removeAll()
            items = detailStatic.theme_ids!
            for view in self.classifyView.subviews{
                view.removeFromSuperview()
            }
            for index in 0..<items.count{
                let label = UILabel.init(frame: CGRect(x:margin*CGFloat(index)+15*CGFloat(index),y:2.5,width:margin,height:25))
                label.text = nil
                label.textAlignment = .center
                label.textColor = UIColor.white
                label.layer.borderColor = UIColor.white.cgColor
                label.layer.borderWidth = 1
                label.layer.masksToBounds = true
                label.layer.cornerRadius = 2
                label.text = items[index]
                label.font = UIFont.systemFont(ofSize: 15)
                self.classifyView.addSubview(label)
            }
        }
    }
    
    var detailRealtime: ComicRealtimeModel? {
        didSet {
            guard let detailRealtime = detailRealtime else { return }
            let text = NSMutableAttributedString(string: "点击 收藏")
            
            text.insert(NSAttributedString(string: " \(detailRealtime.click_total ?? "0") ",
                attributes: [NSAttributedStringKey.foregroundColor: UIColor.orange,
                             NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15)]), at: 2)
            
            text.append(NSAttributedString(string: " \(detailRealtime.favorite_total ?? "0") ",
                attributes: [NSAttributedStringKey.foregroundColor: UIColor.orange,
                             NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15)]))
            self.clickAndCollectL.attributedText = text
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
