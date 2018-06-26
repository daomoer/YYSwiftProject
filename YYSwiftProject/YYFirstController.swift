//
//  YYFirstController.swift
//  YYSwiftProject
//
//  Created by Domo on 2018/6/5.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit
import FSPagerView

class YYFirstController: UIViewController , FSPagerViewDelegate, FSPagerViewDataSource {
    // this is the me first change
    
    ///////////////////////////////////////////banner 滚动图片\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
    fileprivate let sectionTitles = ["https://github.com/WenchaoD/FSPagerView", "循环滚动banner图片", "多种样式可调", "有问题连接github连接原作者"]
    fileprivate let configurationTitles = ["Automatic sliding","Infinite"]
    fileprivate let imageNames = ["pic1.jpeg","pic2.jpeg","pic3.jpeg","pic4.jpeg"]
    fileprivate var numberOfItems = 4
    var pageControl = FSPageControl()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        ///////////////////////////////////////////banner 滚动图片\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
        let pagerView = FSPagerView(frame: CGRect(x:0 , y:64 , width: self.view.frame.size.width , height: 220))
        pagerView.dataSource = self
        pagerView.delegate = self
        pagerView.automaticSlidingInterval = 1.5 - pagerView.automaticSlidingInterval
        pagerView.isInfinite = !pagerView.isInfinite
        pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        self.view.addSubview(pagerView)
        // Create a page control
         self.pageControl = FSPageControl(frame: CGRect(x: 0, y: 254, width: self.view.frame.size.width, height: 30))
        self.pageControl.numberOfPages = self.numberOfItems
        self.pageControl.contentHorizontalAlignment = .right
        self.view.addSubview(pageControl)
        
        
    }
    
    ///////////////////////////////////////////banner 滚动图片\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.numberOfItems
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.image = UIImage(named: self.imageNames[index])
            cell.textLabel?.text = sectionTitles[index]
        return cell
    }
    // MARK:- FSPagerView Delegate
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
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
