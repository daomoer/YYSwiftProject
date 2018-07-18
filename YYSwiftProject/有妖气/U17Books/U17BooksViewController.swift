//
//  U17BooksViewController.swift
//  YYSwiftProject
//
//  Created by Domo on 2018/7/17.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit
import SwipeMenuViewController
// 具体书本界面
class U17BooksViewController: UIViewController {
    var dataSource:[String] = ["详情","目录","评价"]
    
    lazy var swipeMenuView: SwipeMenuView = {
        let swipeMenuView = SwipeMenuView.init(frame: CGRect(x:0, y:64, width: YYScreenWidth, height:YYScreenHeigth-64), options: self.options)
        swipeMenuView.dataSource = self
        swipeMenuView.delegate = self
        return swipeMenuView
    }()
    
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
    
    lazy var bigView : UIView = {
        let view = UIView.init(frame:CGRect(x:0, y:0, width:YYScreenWidth, height:0))
        view.backgroundColor = UIColor.red
        return view
    }()
    
    lazy var navView : UIView = {
        let view = UIView.init(frame: CGRect(x:0, y:0, width: YYScreenWidth, height: 64))
        view.backgroundColor = UIColor.black
        return view
    }()
    
    var vcs:[UIViewController] = [TestController(),U17BooksGuideController(),U17BooksCommendController()]
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(test), name: NSNotification.Name(rawValue:"isTest"), object: nil)
        
        for vc in vcs{
            self.addChildViewController(vc)
        }
        self.view.backgroundColor = UIColor.green
        self.view.addSubview(self.bigView)
        self.view.addSubview(self.navView)
        self.view.addSubview(self.swipeMenuView)
    }

    @objc func test(nofi : Notification){
        let str:String = nofi.userInfo!["post"] as! String
        if str == "向下" {
            UIView.animate(withDuration: 0.25, animations: {
                self.swipeMenuView.frame = CGRect(x:0, y:64, width:YYScreenWidth, height:YYScreenHeigth)
                self.navView.frame = CGRect(x:0, y:0, width:YYScreenWidth, height:64)
                self.bigView.frame = CGRect(x:0, y:0, width:YYScreenWidth, height:0)
            })
        }else {
            UIView.animate(withDuration: 0.25, animations: {
                self.swipeMenuView.frame = CGRect(x:0, y:240, width:YYScreenWidth, height:YYScreenHeigth)
                self.navView.frame = CGRect(x:0, y:0, width:YYScreenWidth, height:0)
                self.bigView.frame = CGRect(x:0, y:0, width:YYScreenWidth, height:240)
            })
        }
    }
    
    deinit {
        /// 移除通知
        NotificationCenter.default.removeObserver(self)
    }
}

extension U17BooksViewController: SwipeMenuViewDelegate {
    
}

extension U17BooksViewController: SwipeMenuViewDataSource {
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


