//
//  U17RecommendHeaderView.swift
//  YYSwiftProject
//
//  Created by Domo on 2018/7/17.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit

// 创建闭包
typealias HeaderMoreBtnClick = () ->Void

class U17RecommendHeaderView: UICollectionReusableView {
    
    var headerMoreBtnClick : HeaderMoreBtnClick?
    
    lazy var imageView = UIImageView()
    lazy var titleL = UILabel()
    lazy var moreBtn : UIButton = {
        let btn = UIButton.init(type: UIButtonType.custom)
            btn.setImage(UIImage(named:"small_change"), for: UIControlState.normal)
            btn.addTarget(self, action: #selector(btnChange(button:)), for: UIControlEvents.touchUpInside)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    func setUpUI(){
        self.addSubview(self.imageView)
        self.imageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(30)
            make.left.equalTo(10)
            make.top.equalTo(5)
        }
        
        self.addSubview(self.titleL)
        self.titleL.snp.makeConstraints { (make) in
            make.width.equalTo(200)
            make.left.equalTo(40)
            make.height.equalTo(30)
            make.top.equalTo(5)
        }
        
        self.addSubview(self.moreBtn)
        self.moreBtn.snp.makeConstraints { (make) in
            make.width.height.equalTo(40)
            make.top.equalTo(0)
            make.right.equalTo(-10)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc func btnChange(button:UIButton){
        guard let headerMoreBtnClick = headerMoreBtnClick else { return }
        headerMoreBtnClick()
    }
}



