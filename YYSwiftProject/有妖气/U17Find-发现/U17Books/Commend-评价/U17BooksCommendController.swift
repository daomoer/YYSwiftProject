//
//  U17BooksCommendController.swift
//  YYSwiftProject
//
//  Created by Domo on 2018/7/18.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit

private let IMAGE_HEIGHT:CGFloat = 220
private let kNavBarBottom = WRNavigationBar.navBarBottom()
private let NAVBAR_COLORCHANGE_POINT:CGFloat = IMAGE_HEIGHT - CGFloat(kNavBarBottom * 2)

// 书本评论界面
class U17BooksCommendController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private var comicid: Int = 0
 
    private var detailStatic: DetailStaticModel?
    private var detailRealtime: DetailRealtimeModel?
    private var commentList : CommentListModel?
    
    private let BooksCommendCellIdentifier = "BooksCommendCell"
//    private var listArray = [UCommentViewModel]()

    
    lazy var tableView : UITableView = {
        let tableView = UITableView.init(frame: CGRect(x:0, y:0, width:YYScreenWidth, height:YYScreenHeigth-64-44))
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(BooksCommendCell.self, forCellReuseIdentifier: BooksCommendCellIdentifier)

        return tableView
    }()
    
    convenience init(comicid: Int, commentList: CommentListModel?) {
        self.init()
        self.comicid = comicid
        self.commentList = commentList
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.commentList?.commentList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return BooksCommendCell.height(for: self.commentList?.commentList![indexPath.row])

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell:BooksCommendCell = tableView.dequeueReusableCell(withIdentifier: BooksCommendCellIdentifier, for: indexPath) as! BooksCommendCell
        cell.model = commentList?.commentList![indexPath.row]
        return cell
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let nosetY : CGFloat = 0.0
        if (offsetY > NAVBAR_COLORCHANGE_POINT)
        {
            let alpha = (offsetY - NAVBAR_COLORCHANGE_POINT) / CGFloat(kNavBarBottom)
            NotificationCenter.default.post(name: NSNotification.Name("moveHeaderView"), object: self, userInfo: ["post":alpha])
        }
        else
        {
            NotificationCenter.default.post(name: NSNotification.Name("moveHeaderView"), object: self, userInfo: ["post":nosetY])
        }
    }
}
