//
//  YYSecondController.swift
//  YYSwiftProject
//
//  Created by Domo on 2018/6/5.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit
import SwipeMenuViewController

class U17Controller: SwipeMenuViewController {
    var options = SwipeMenuViewOptions()
    var dataSource:[String] = ["推荐","VIP","订阅","排行"]
    var vcs:[UIViewController] = [U17RecommendController(),U17VIPController(),U17SubController(),U17RankController()]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navBarBackgroundAlpha = 0
        for vc in vcs{
            self.addChildViewController(vc)
        }
        
        self.view.backgroundColor = DominantColor
        self.options.tabView.style = .segmented
        self.options.tabView.itemView.textColor = UIColor.init(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1)
        self.options.tabView.itemView.selectedTextColor = UIColor.white
        self.options.tabView.itemView.width = 60.0
        self.options.tabView.margin = 70.0
        self.options.tabView.itemView.font = UIFont.systemFont(ofSize: 20)
        self.options.tabView.addition = .none
        self.swipeMenuView.reloadData(options: options)
                        
        let button = UIButton.init(type:.custom)
        button.frame = CGRect(x:YYScreenWidth-60,y:20, width:40,height:40)
        button.setImage(UIImage(named:"search"), for: .normal)
        button.setImage(UIImage(named:"search"), for: .selected)
        button .addTarget(self, action:#selector(buttonClick), for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    @objc func buttonClick(){
        let searchVC = U17SearchController()
        self.navigationController?.pushViewController(searchVC, animated: true)
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
    
}









