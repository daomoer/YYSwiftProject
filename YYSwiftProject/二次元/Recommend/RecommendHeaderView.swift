//
//  RecommendHeaderView.swift
//  YYSwiftProject
//
//  Created by Domo on 2018/7/16.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit
typealias changeBtnClick = (_ isSelect:Bool) ->Void
class RecommendHeaderView: UIView {
    lazy var imageView = UIImageView()
    lazy var titleL = UILabel()
    lazy var changeBtn = UIButton()
    var headerChangeBtnClick: changeBtnClick?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setUpUI(){
        self.addSubview(self.imageView)
        self.imageView.snp.makeConstraints { (make) in
           make.width.height.equalTo(30)
           make.left.equalTo(15)
           make.top.equalTo(5)
        }
        
        self.addSubview(self.titleL)
        self.titleL.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.left.equalTo(60)
            make.height.equalTo(30)
            make.top.equalTo(5)
        }
        
        self.addSubview(self.changeBtn)
        self.changeBtn.setImage(UIImage(named:"big_change"), for: UIControlState.normal)
        self.changeBtn.addTarget(self, action: #selector(btnChange(button:)), for: UIControlEvents.touchUpInside)
        self.changeBtn.snp.makeConstraints { (make) in
            make.width.height.equalTo(40)
            make.top.equalTo(0)
            make.right.equalTo(-10)
        }
    }
    @objc func btnChange(button:UIButton){
        button.isSelected = !button.isSelected
        if button.isSelected {
            self.changeBtn.setImage(UIImage(named:"small_change"), for: UIControlState.normal)
        }else{
            self.changeBtn.setImage(UIImage(named:"big_change"), for: UIControlState.normal)
        }
        guard let headerChangeBtnClick = headerChangeBtnClick else { return }
        headerChangeBtnClick(button.isSelected)
    }

}
