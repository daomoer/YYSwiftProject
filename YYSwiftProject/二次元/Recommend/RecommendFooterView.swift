//
//  RecommendFooterView.swift
//  YYSwiftProject
//
//  Created by Domo on 2018/7/16.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit


class RecommendFooterView: UIView {
    lazy var button:UIButton = {
        let button = UIButton.init(type: UIButtonType.custom)
        button.frame = CGRect(x:YYScreenWidth/2-75,y:10,width:150,height:30)
        button.setTitle("更多", for: UIControlState.normal)
        button.setTitleColor(DominantColor, for: UIControlState.normal)
        button.setImage(UIImage(named:"comeon"), for: UIControlState.normal)
        button.imageEdgeInsets = UIEdgeInsetsMake(0, 110, 0, 0)
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 30)
        button.addTarget(self, action: #selector(buttonClick(button:)), for: UIControlEvents.touchUpInside)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.button)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    @objc func buttonClick(button:UIButton){
        print("ddd")
    }
    
    var title: String? {
        didSet {
            self.button.setTitle(title, for: UIControlState.normal)
        }
    }
    
    
}
