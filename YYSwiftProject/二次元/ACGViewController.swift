//
//  ACGViewController.swift
//  YYSwiftProject
//
//  Created by Domo on 2018/7/11.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit
import SwipeMenuViewController

class ACGViewController: SwipeMenuViewController {
    var dataSource:[String] = ["推荐","插画","文章","COS"]
    var options = SwipeMenuViewOptions()
    var vcs:[UIViewController] = [RecommendController(),IkonController(),EssayController(),COSController()]

    override func viewDidLoad() {
        super.viewDidLoad()
        for vc in vcs{
            self.addChildViewController(vc)
        }
        self.view.backgroundColor = UIColor.white
        self.options.tabView.style = .segmented
        self.options.tabView.itemView.textColor = UIColor.lightGray
        self.options.tabView.itemView.selectedTextColor = UIColor.black
        self.options.tabView.backgroundColor = UIColor.white
        self.options.tabView.itemView.width = 60.0
        self.options.tabView.margin = 20.0
        self.options.tabView.itemView.font = UIFont.systemFont(ofSize: 15)
        self.options.tabView.underlineView.height = 3.0
        self.options.tabView.underlineView.backgroundColor = DominantColor
        
        self.swipeMenuView.reloadData(options: options)
    }
    
    // MARK: - SwipeMenuViewDelegate
    override func swipeMenuView(_ swipeMenuView: SwipeMenuView, viewWillSetupAt currentIndex: Int) {
        super.swipeMenuView(swipeMenuView, viewWillSetupAt: currentIndex)
        print("will setup SwipeMenuView")
    }
    
    override func swipeMenuView(_ swipeMenuView: SwipeMenuView, viewDidSetupAt currentIndex: Int) {
        super.swipeMenuView(swipeMenuView, viewDidSetupAt: currentIndex)
        print("did setup SwipeMenuView")
    }
    
    override func swipeMenuView(_ swipeMenuView: SwipeMenuView, willChangeIndexFrom fromIndex: Int, to toIndex: Int) {
        super.swipeMenuView(swipeMenuView, willChangeIndexFrom: fromIndex, to: toIndex)
        print("will change from section\(fromIndex + 1)  to section\(toIndex + 1)")
    }
    
    override func swipeMenuView(_ swipeMenuView: SwipeMenuView, didChangeIndexFrom fromIndex: Int, to toIndex: Int) {
        super.swipeMenuView(swipeMenuView, didChangeIndexFrom: fromIndex, to: toIndex)
        print("did change from section\(fromIndex + 1)  to section\(toIndex + 1)")
    }
    
    
    // MARK - SwipeMenuViewDataSource
    
    override func numberOfPages(in swipeMenuView: SwipeMenuView) -> Int {
        return dataSource.count
    }
    
    override func swipeMenuView(_ swipeMenuView: SwipeMenuView, titleForPageAt index: Int) -> String {
        return dataSource[index]
    }
    
    override func swipeMenuView(_ swipeMenuView: SwipeMenuView, viewControllerForPageAt index: Int) -> UIViewController {
        let vc = vcs[index]
        return vc
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
