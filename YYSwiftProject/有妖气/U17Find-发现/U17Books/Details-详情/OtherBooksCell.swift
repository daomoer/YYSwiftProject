//
//  OtherBooksCell.swift
//  YYSwiftProject
//
//  Created by Domo on 2018/7/19.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit

class OtherBooksCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
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
    
//    var model: DetailStaticModel? {
//        didSet{
//            guard let model = model else { return }
//            textLabel?.text = "其他作品"
//            detailTextLabel?.text = "\(model.otherWorks?.count ?? 0)本"
//            detailTextLabel?.font = UIFont.systemFont(ofSize: 15)
//        }
//    }

}
