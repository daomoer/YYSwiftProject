//
//  RecommendGridView.swift
//  YYSwiftProject
//
//  Created by Domo on 2018/7/12.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit

class RecommendGridView: UIView {
    
    public var titleArray : NSArray = []{
        didSet {
            setUpUI()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    // 循环创建分类按钮
    func setUpUI(){
        let nums:CGFloat = CGFloat(titleArray.count*2+1)
        let margin:CGFloat = self.frame.width/nums

        for index in 0..<titleArray.count {
            let button = UIButton.init(frame: CGRect(x:margin*CGFloat(index)*2+margin,y:10,width:margin,height:margin))
            button.backgroundColor = UIColor.red
            self.addSubview(button)
            
            let label = UILabel()
            label.backgroundColor = UIColor.purple
            label.textAlignment = .center
            label.text = titleArray[index] as? String
            self.addSubview(label)
            label.snp.makeConstraints({ (make) in
                make.centerX.equalTo(button)
                make.width.equalTo(margin+20)
                make.top.equalTo(margin+10+5)
            })
 
            
//            //分别设置图片下文字和点击方法
//            switch index {
//            case 0:
//                label.text = "插画榜"
//                button.addTarget(self, action: #selector(tapped1), for: UIControlEvents.touchUpInside)
//            case 1:
//                label.text = "人气画师"
//                button.addTarget(self, action: #selector(tapped2), for: UIControlEvents.touchUpInside)
//            default:
//                label.text = "专题精选"
//                button.addTarget(self, action: #selector(tapped3), for: UIControlEvents.touchUpInside)
//            }

        }
    }
//    @objc func tapped1() {
//        print("111")
//    }
//    
//    @objc func tapped2() {
//        print("222")
//    }
//    
//    @objc func tapped3() {
//        print("333")
//    }
    
}
