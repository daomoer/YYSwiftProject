//
//  IkonBannerView.swift
//  YYSwiftProject
//
//  Created by Domo on 2018/7/13.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit
import FSPagerView

class IkonBannerView: UIView , FSPagerViewDataSource, FSPagerViewDelegate{
    lazy var bgView = UIView() //毛玻璃效果
    lazy var iconImage = UIImageView()
    lazy var nickNameL = UILabel()
    lazy var recommendL = UILabel()
    lazy var addressL = UILabel()
    lazy var pagerView = FSPagerView()
    lazy var pageControl = FSPageControl()
    fileprivate let imageNames = ["pic1.jpeg","pic2.jpeg","pic3.jpeg","pic4.jpeg"]
    fileprivate var numberOfItems = 4
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setUpUI(){
        self.addSubview(self.bgView)
        self.bgView.snp.makeConstraints { (make) in
            make.width.height.equalTo(self)
            make.center.equalTo(self)
        }
        
        self.iconImage.backgroundColor = UIColor.red
        self.addSubview(self.iconImage)
        self.iconImage.snp.makeConstraints { (make) in
            make.width.height.equalTo(50)
            make.top.equalTo(15)
            make.left.equalTo(15)
        }
        
        self.nickNameL.backgroundColor = UIColor.orange
        self.addSubview(self.nickNameL)
        self.nickNameL.snp.makeConstraints { (make) in
            make.width.equalTo(200)
            make.height.equalTo(30)
            make.left.equalTo(80)
            make.top.equalTo(25)
        }
        
        self.recommendL.backgroundColor = UIColor.green
        self.addSubview(self.recommendL)
        self.recommendL.snp.makeConstraints { (make) in
            make.width.equalTo(80)
            make.height.equalTo(30)
            make.right.equalTo(-15)
            make.top.equalTo(25)
        }
        
        self.addressL.backgroundColor = UIColor.purple
        self.addSubview(self.addressL)
        self.addressL.snp.makeConstraints { (make) in
            make.width.equalTo(300)
            make.height.equalTo(30)
            make.left.equalTo(80)
            make.top.equalTo(70)
        }
        
        self.pagerView.dataSource = self
        self.pagerView.delegate = self
        self.pagerView.automaticSlidingInterval =  3
        self.pagerView.isInfinite = !pagerView.isInfinite
        //        self.pagerView.interitemSpacing = 50
        self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        self.addSubview(self.pagerView)
        self.pagerView.snp.makeConstraints { (make) in
            make.width.equalTo(self)
            make.height.equalTo(200)
            make.left.equalTo(0)
            make.top.equalTo(120)
        }
        
        self.pageControl.numberOfPages = self.numberOfItems
        self.pageControl.contentHorizontalAlignment = .center
        self.addSubview(self.pageControl)
        self.pageControl.snp.makeConstraints { (make) in
            make.width.equalTo(80)
            make.height.equalTo(30)
            make.bottom.equalTo(0)
            make.centerX.equalTo(self)
        }
    }
    // MARK:- FSPagerView Delegate
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return numberOfItems
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.image = UIImage(named: self.imageNames[index])
        
        blurImage(imageName: self.imageNames[index])
        
        return cell
    }
    
    func blurImage(imageName : String) -> Void {
        let blurImageView = UIImageView.init(frame:  CGRect(x:0 , y:0 , width: YYScreenWidth , height: self.frame.height))
        blurImageView.image = UIImage(named: imageName)
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light)) as UIVisualEffectView
        visualEffectView.frame = blurImageView.bounds
        //        //添加毛玻璃效果层
        blurImageView.addSubview(visualEffectView)
        self.insertSubview(blurImageView, belowSubview: self.bgView)
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
        pagerView.scrollToItem(at: index, animated: true)
        self.pageControl.currentPage = index
    }
    
    func pagerViewDidScroll(_ pagerView: FSPagerView) {
        guard self.pageControl.currentPage != pagerView.currentIndex else {
            return
        }
        self.pageControl.currentPage = pagerView.currentIndex // Or Use KVO with property "currentIndex"
    }
}

