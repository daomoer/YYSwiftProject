//
//  U17BannerViewCell.swift
//  YYSwiftProject
//
//  Created by Domo on 2018/7/17.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit
import FSPagerView
// 创建闭包
typealias U17GridBtnClick = (_ tag : Int) ->Void
// 创建闭包
typealias U17BannerClick = (_ tag : Int) ->Void

class U17BannerViewCell: UICollectionViewCell,FSPagerViewDelegate, FSPagerViewDataSource {

    var u17GridBtnClick :  U17GridBtnClick?
    var u17BannerClick :  U17BannerClick?

    
    lazy var pagerView = FSPagerView()
    lazy var pageControl = FSPageControl()
    lazy var gridView = RecommendGridView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
            make.height.equalTo(180)
            make.left.equalTo(0)
            make.top.equalTo(0)
        }
        
        self.pageControl.numberOfPages = self.imagePaths.count
        self.pageControl.contentHorizontalAlignment = .center
        self.addSubview(self.pageControl)
        self.pageControl.snp.makeConstraints { (make) in
            make.width.equalTo(80)
            make.height.equalTo(20)
            make.bottom.equalTo(-80)
            make.right.equalTo(0)
        }
    }
    
    func setUpGridView(model:ComicListModel){
        let titleArray = NSMutableArray()
        let btnImageArray = NSMutableArray()
        self.gridView = RecommendGridView.init(frame: CGRect(x:0,y:175,width:YYScreenWidth,height:80))
        let list = model.comics
        for model in list!{
            titleArray.add(model.name!)
            btnImageArray.add(model.cover!)
        }
        self.gridView.titleArray = titleArray as! Array<String>
        self.gridView.btnImageArray = btnImageArray as! Array<String>
        self.gridView.gridBtnClick = {[weak self](tag) in
            guard let u17GridBtnClick = self?.u17GridBtnClick else { return }
            u17GridBtnClick(tag)
        }
        self.addSubview(self.gridView)
    }
    
    // MARK:- FSPagerView Delegate
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.imagePaths.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.kf.setImage(with: URL(string:self.imagePaths[index]))
        return cell
    }
    
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        guard let u17BannerClick = self.u17BannerClick else { return }
        u17BannerClick(index)
        pagerView.deselectItem(at: index, animated: true)
        pagerView.scrollToItem(at: index, animated: true)
        self.pageControl.currentPage = index
    }
    
    func pagerViewDidScroll(_ pagerView: FSPagerView) {
        guard self.pageControl.currentPage != pagerView.currentIndex else {
            return
        }
        self.pageControl.currentPage = pagerView.currentIndex
    }
    

    open var imagePaths: Array<String> = [] {
        didSet {
            setUpUI()
            self.pagerView.reloadData()
        }
    }
    
    
   open var comicListModel:ComicListModel? {
        didSet {
            guard let model = comicListModel else { return }
            setUpGridView(model:model)
        }
    }

}
