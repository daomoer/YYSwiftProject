//
//  U17TodayCell.swift
//  YYSwiftProject
//
//  Created by Domo on 2018/7/23.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit

class U17TodayCell: UITableViewCell {
    lazy var picImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 20.0
        return imageView
    }()
    
    lazy var button: UIButton = {
        let button = UIButton.init(type: UIButtonType.custom)
        button.backgroundColor = DominantColor
        button.setTitle("阅读漫画", for: UIControlState.normal)
        button.setTitleColor(UIColor.white, for: UIControlState.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 15
        return button
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
    
    func setUpUI(){
        self.addSubview(self.picImageView)
        self.picImageView.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(15)
            make.right.bottom.equalToSuperview().offset(-15)
        }
        
        self.picImageView.addSubview(self.button)
        self.button.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.right.bottom.equalToSuperview().offset(-25)
            make.height.equalTo(30)
        }
        
    }
    
    var model: DayItemModel? {
        didSet{
            guard let model = model else { return }
            self.picImageView.kf.setImage(with: URL(string:model.cover!))
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
