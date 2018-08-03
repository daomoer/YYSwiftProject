//
//  U17BookRackController.swift
//  YYSwiftProject
//
//  Created by Domo on 2018/7/24.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit
import SwipeMenuViewController

class U17BookRackController: UIViewController {
    
    
    private var dataSource:[String] = ["收藏","书单","历史","下载"]
    private var vcs:[UIViewController] = [U17CollectController(),U17BookListController(),U17HistoryController(),U17DownloadController()]
    
    lazy var options : SwipeMenuViewOptions = {
        var options = SwipeMenuViewOptions()
        options.tabView.style = .segmented
        options.tabView.itemView.textColor = UIColor.black
        options.tabView.itemView.selectedTextColor = DominantColor
        options.tabView.backgroundColor = UIColor.white
        options.tabView.itemView.width = 60.0
        options.tabView.margin = 20.0
        options.tabView.itemView.font = UIFont.systemFont(ofSize: 15)
        options.tabView.underlineView.height = 3.0
        options.tabView.underlineView.backgroundColor = DominantColor
        return options
    }()
    
    lazy var swipeMenuView: SwipeMenuView = {
        let swipeMenuView = SwipeMenuView.init(frame: CGRect(x:0, y:64, width: YYScreenWidth, height:YYScreenHeigth-64), options:self.options)
        swipeMenuView.dataSource = self
        swipeMenuView.delegate = self
        return swipeMenuView
    }()
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
//        self.navigationController?.navigationBar.isHidden = true
//    }
//    
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidAppear(true)
//        self.navigationController?.navigationBar.isHidden = false
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        // MARK: - 必须遍历一下不然不显示各分控制器
//        for vc in vcs{
//            self.addChildViewController(vc)
//        }
//        self.navBarBackgroundAlpha = 0
//        self.title = nil
//        self.view.addSubview(self.swipeMenuView)
    }
}

// MARK: - SwipeMenuViewDelegate

extension U17BookRackController: SwipeMenuViewDelegate {
    
}

extension U17BookRackController: SwipeMenuViewDataSource {
    func numberOfPages(in swipeMenuView: SwipeMenuView) -> Int {
        return dataSource.count
    }
    
    func swipeMenuView(_ swipeMenuView: SwipeMenuView, titleForPageAt index: Int) -> String {
        return dataSource[index]
    }
    
    func swipeMenuView(_ swipeMenuView: SwipeMenuView, viewControllerForPageAt index: Int) -> UIViewController {
        let vc = vcs[index]
        return vc
    }
}



