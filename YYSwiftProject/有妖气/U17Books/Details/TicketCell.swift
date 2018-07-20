//
//  TicketCell.swift
//  YYSwiftProject
//
//  Created by Domo on 2018/7/19.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit

class TicketCell: UITableViewCell {
    lazy var monthTicketLabel : UILabel = {
       let label = UILabel()
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
    
   private func setUpUI(){
      self.addSubview(self.monthTicketLabel)
    self.monthTicketLabel.snp.makeConstraints { (make) in
        make.top.equalTo(10)
        make.left.equalTo(15)
        make.bottom.equalTo(-10)
        make.right.equalTo(-15)
        }
    }
    
    var model : DetailRealtimeModel? {
        didSet {
            guard let model = model else { return }
            let text = NSMutableAttributedString(string: "本月月票       |     累计月票  ",
                                                 attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray,
                                                              NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)])
            text.append(NSAttributedString(string: "\(model.comic?.total_ticket ?? "")",
                attributes: [NSAttributedStringKey.foregroundColor: UIColor.orange,
                             NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16)]))
            text.insert(NSAttributedString(string: "\(model.comic?.monthly_ticket ?? "")",
                attributes: [NSAttributedStringKey.foregroundColor: UIColor.orange,
                             NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16)]),
                        at: 6)
            self.monthTicketLabel.attributedText = text
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
