//
//  BooksCommendCell.swift
//  YYSwiftProject
//
//  Created by Domo on 2018/7/19.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit

class BooksCommendCell: UITableViewCell {
    lazy var iconImageView : UIImageView = {
        let imageView = UIImageView()
 
        return imageView
    }()
    
    lazy var nickName : UILabel = {
        let nickName = UILabel()
        nickName.textColor = UIColor.gray
        nickName.font = UIFont.systemFont(ofSize: 15)
        return nickName
    }()
    
    lazy var commentLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        return label
    }()
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
    
    func setUpUI(){
        self.addSubview(self.iconImageView)
        self.iconImageView.layer.masksToBounds = true
        self.iconImageView.layer.cornerRadius = 20
        self.iconImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(40)
            make.left.top.equalTo(10)
        }
        
        self.addSubview(self.nickName)
        self.nickName.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.left.equalTo(self.iconImageView.snp.right).offset(10)
            make.right.equalToSuperview()
            make.height.equalTo(20)
        }
        
        self.addSubview(self.commentLabel)
        self.commentLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.nickName.snp.left)
            make.top.equalTo(self.nickName.snp.bottom)
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var model: CommentModel? {
        didSet{
            guard let model = model else { return }
            self.iconImageView.kf.setImage(with: URL(string:model.face!))
            self.nickName.text = model.nickname
            self.commentLabel.text = model.content_filter
        }
    }
    
    class func height(for commentModel: CommentModel?) -> CGFloat {
        var height: CGFloat = 44
        guard let model = commentModel else { return height }
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        label.text = model.content_filter
        height += label.sizeThatFits(CGSize(width: YYScreenWidth - 30, height: CGFloat.infinity)).height+20
        return height
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

