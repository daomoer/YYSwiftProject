//
//  BookIntroduceCell.swift
//  YYSwiftProject
//
//  Created by Domo on 2018/7/19.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit

class BookIntroduceCell: UITableViewCell {
    lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    
    lazy var textView : UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 15)
        textView.textColor = UIColor.gray
        return textView
    }()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
    
    func setUpUI(){
        self.addSubview(self.titleLabel)
        self.titleLabel.text = "作品介绍"
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(5)
            make.height.equalTo(20)
            make.right.equalTo(-15)
        }
        
        self.addSubview(self.textView)
        self.textView.snp.makeConstraints { (make) in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(5)
            make.bottom.equalToSuperview().offset(-15)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
        }
        
    }
    
    
    var model: DetailStaticModel? {
        didSet{
            guard let model = model else { return }
            textView.text = "【\(model.comic?.cate_id ?? "")】\(model.comic?.description ?? "")"
        }
    }
    
    class func height(for detailStatic: DetailStaticModel?) -> CGFloat {
        var height: CGFloat = 50.0
        guard let model = detailStatic else { return height }
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 15)
        textView.text = "【\(model.comic?.cate_id ?? "")】\(model.comic?.description ?? "")"
        height += textView.sizeThatFits(CGSize(width: YYScreenWidth - 30, height: CGFloat.infinity)).height
        return height
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
