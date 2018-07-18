//
//  U17BannerViewCell.swift
//  YYSwiftProject
//
//  Created by Domo on 2018/7/17.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit
import FSPagerView

class U17BannerViewCell: UICollectionViewCell,FSPagerViewDelegate, FSPagerViewDataSource {
    
    lazy var pagerView = FSPagerView()
    lazy var pageControl = FSPageControl()
    fileprivate let imageNames = ["pic1.jpeg","pic2.jpeg","pic3.jpeg","pic4.jpeg"]
    fileprivate var numberOfItems = 4
    
    lazy var gridView = RecommendGridView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setUpUI(){
        self.pagerView.dataSource = self
        self.pagerView.delegate = self
        self.pagerView.automaticSlidingInterval =  3
        self.pagerView.isInfinite = !pagerView.isInfinite
        self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        self.addSubview(self.pagerView)
        self.pagerView.snp.makeConstraints { (make) in
            make.width.equalTo(self)
            make.height.equalTo(150)
            make.left.equalTo(0)
            make.top.equalTo(0)
        }
        
        self.pageControl.numberOfPages = self.numberOfItems
        self.pageControl.contentHorizontalAlignment = .center
        self.addSubview(self.pageControl)
        self.pageControl.snp.makeConstraints { (make) in
            make.width.equalTo(80)
            make.height.equalTo(20)
            make.bottom.equalTo(-90)
            make.right.equalTo(0)
        }
        
        self.gridView = RecommendGridView.init(frame: CGRect(x:0,y:150,width:YYScreenWidth,height:90))
        self.gridView.titleArray = ["周榜","VIP榜","畅销榜","排行榜"]
        self.addSubview(self.gridView)
    }
    
    // MARK:- FSPagerView Delegate
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return numberOfItems
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.image = UIImage(named: self.imageNames[index])
        
        return cell
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
