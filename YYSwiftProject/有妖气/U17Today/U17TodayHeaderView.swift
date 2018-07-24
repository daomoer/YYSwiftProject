//
//  U17TodayHeaderView.swift
//  YYSwiftProject
//
//  Created by Domo on 2018/7/23.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit

class U17TodayHeaderView: UITableViewHeaderFooterView {
    lazy var weekLabel: UILabel = {
        let label = UILabel()
        label.text = "星期日"
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 30)
        return label
    }()
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "07月22日"
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.addSubview(self.timeLabel)
        self.timeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.equalTo(30)
            make.height.equalTo(30)
            make.right.equalToSuperview()
        }
        
        self.addSubview(self.weekLabel)
        self.weekLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.timeLabel.snp.left)
            make.top.equalTo(self.timeLabel.snp.bottom)
            make.height.equalTo(45)
            make.right.equalTo(self.timeLabel.snp.right)
        }
    
    }
    
    var dayDataModel: DayItemDataListModel? {
        didSet{
            guard let model = dayDataModel else { return }
            self.weekLabel.text = model.weekDay
            let time = (model.timeStamp! as NSString).intValue
            let confromTimestampDate = NSDate.init(timeIntervalSince1970: TimeInterval(time))
            let timeStr = dateConvertString(date: confromTimestampDate as Date)
            self.timeLabel.text = timeStr
        }
    }
    
    func dateConvertString(date:Date, dateFormat:String="yyyy-MM-dd") -> String {
        let timeZone = TimeZone.init(identifier: "UTC")
        let formatter = DateFormatter()
        formatter.timeZone = timeZone
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = dateFormat
        let date = formatter.string(from: date)
        return date.components(separatedBy: " ").first!
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
