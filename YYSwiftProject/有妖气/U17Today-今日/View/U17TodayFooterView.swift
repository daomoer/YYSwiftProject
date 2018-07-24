//
//  U17TodayFooterView.swift
//  YYSwiftProject
//
//  Created by Domo on 2018/7/23.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit

protocol U17TodayFooterViewDelegate: NSObjectProtocol{
    func readCartoon(dayComicItemModel: dayComicItemModel?)
}


class U17TodayFooterView: UITableViewHeaderFooterView , UITableViewDelegate, UITableViewDataSource{
    weak var delegate:U17TodayFooterViewDelegate?
    
    private var dayComicItemList: [dayComicItemModel]?
    lazy var bgView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 20
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "小编推荐"
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 24)
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    lazy var button: UIButton = {
        let button = UIButton.init(type: UIButtonType.custom)
        button.backgroundColor = UIColor.init(red: 239/255.0, green: 239/255.0, blue: 239/255.0, alpha: 1)
        button.setTitle("☆ 收藏", for: UIControlState.normal)
        button.setTitleColor(DominantColor, for: UIControlState.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 5
        return button
    }()
    
    private let CellIdentifier = "U17TodayFooterCell"
    lazy var tableView : UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.register(U17TodayFooterCell.self, forCellReuseIdentifier: CellIdentifier)
        return tableView
    }()
    
    func setUpUI(){
        self.addSubview(self.bgView)
        self.bgView.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(15)
            make.right.bottom.equalToSuperview().offset(-15)
        }
        
        self.backgroundColor = UIColor.white
        self.bgView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.left.right.equalToSuperview()
            make.height.equalTo(40)
        }
        
        self.bgView.addSubview(self.button)
        self.button.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-10)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
            make.width.equalTo(120)
        }
        
        self.bgView.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(60)
            make.bottom.equalToSuperview().offset(-60)
        }
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
    
    
    var dayItemModel: DayItemModel? {
        didSet{
            guard let model = dayItemModel else { return }
            self.titleLabel.text = model.comicListTitle
            self.dayComicItemList = model.dayComicItemList
            self.tableView.reloadData()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:U17TodayFooterCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier, for: indexPath) as! U17TodayFooterCell
        cell.dayComicItem = self.dayComicItemList?[indexPath.row]
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        do {
            delegate?.readCartoon(dayComicItemModel: self.dayComicItemList?[indexPath.row])
        }
    }
}
