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
    private var comicid: Int = 0
    private var titleStr: String?

    
    private var detailStatic: DetailStaticModel?
    private var detailRealtime: DetailRealtimeModel?
    private var guessLike: GuessLikeModel?
    private var commentList: CommentListModel?

    
    var dataSource:[String] = ["详情","目录","评价"]
    
    lazy var headView : U17BooksHeaderView = {
        let view = U17BooksHeaderView.init(frame:CGRect(x:0, y:0, width:YYScreenWidth, height:240))
        return view
    }()
    
    lazy var swipeMenuView: SwipeMenuView = {
        let swipeMenuView = SwipeMenuView.init(frame: CGRect(x:0, y:self.headView.frame.size.height, width: YYScreenWidth, height:YYScreenHeigth-64), options: self.options)
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
    
    convenience init(comicid: Int, titleStr: String?) {
        self.init()
        self.comicid = comicid
        self.titleStr = titleStr
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navBarBackgroundAlpha = 0
        self.title = nil
        self.view.backgroundColor = UIColor.white
        NotificationCenter.default.addObserver(self, selector: #selector(move), name: NSNotification.Name(rawValue:"moveHeaderView"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(upData), name: NSNotification.Name(rawValue:"OtherWorksComicid"), object: nil)
        
        loadData()
    }
    
    private func loadData() {
        
        let grpup = DispatchGroup()
        
        grpup.enter()
        ApiLoadingProvider.request(UApi.detailStatic(comicid: comicid),
                                   model: DetailStaticModel.self) { [weak self] (detailStatic) in
                                    self?.detailStatic = detailStatic
                                    self?.headView.detailStatic = detailStatic?.comic
                                    self?.titleStr = detailStatic?.comic?.name
                                    ApiProvider.request(UApi.commentList(object_id: detailStatic?.comic?.comic_id ?? 0,
                                                                         thread_id: detailStatic?.comic?.thread_id ?? 0,
                                                                         page: -1),
                                                        model: CommentListModel.self,
                                                        completion: { [weak self] (commentList) in
                                                            self?.commentList = commentList
                                                            grpup.leave()
                                    })
        }
        
        grpup.enter()
        ApiProvider.request(UApi.detailRealtime(comicid: comicid),
                            model: DetailRealtimeModel.self) { [weak self] (returnData) in
                                self?.detailRealtime = returnData
                                self?.headView.detailRealtime = returnData?.comic
                                grpup.leave()
        }
        
        grpup.enter()
        ApiProvider.request(UApi.guessLike, model: GuessLikeModel.self) { (returnData) in
            self.guessLike = returnData
            grpup.leave()
        }
        
        grpup.notify(queue: DispatchQueue.main) {
            self.view.addSubview(self.headView)
            self.view.addSubview(self.swipeMenuView)
            self.swipeMenuView.reloadData()
        }
    }
    
    @objc func upData(nofi : Notification){
        self.comicid = nofi.userInfo!["Comicid"] as! Int
        loadData()
    }

    @objc func move(nofi : Notification){
        let offsetY:CGFloat = nofi.userInfo!["post"] as! CGFloat
        if offsetY>0 {
            UIView.animate(withDuration: 0.5, animations: {
                self.headView.frame = CGRect(x:0, y:-240, width:YYScreenWidth, height:240)
                self.swipeMenuView.frame = CGRect(x:0, y:64, width: YYScreenWidth, height:YYScreenHeigth)
                self.navBarBackgroundAlpha = offsetY
                self.title = self.titleStr
            }, completion: nil)
        }else{
            UIView.animate(withDuration: 0.5, animations: {
                self.headView.frame = CGRect(x:0, y:0, width:YYScreenWidth, height:240)
                self.swipeMenuView.frame = CGRect(x:0, y:self.headView.frame.size.height, width: YYScreenWidth, height:YYScreenHeigth)
                self.navBarBackgroundAlpha = 0
                self.title = nil
            }, completion: nil)
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
        if index == 0 {
            let vc = U17BooksDetailController.init(comicid: self.comicid, detailStatic: self.detailStatic, detailRealtime: self.detailRealtime, guessLike: self.guessLike )
            self.addChildViewController(vc)
            return vc
        }else if index == 1 {
            let vc = U17BooksGuideController.init(comicid: self.comicid, detailStatic: self.detailStatic)
            self.addChildViewController(vc)
            return vc
        }else {
            let vc = U17BooksCommendController.init(comicid: self.comicid, commentList:self.commentList)
            self.addChildViewController(vc)
            return vc
        }
    }
}


