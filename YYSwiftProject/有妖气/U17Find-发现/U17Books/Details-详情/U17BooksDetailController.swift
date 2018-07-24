//
//  U17BooksDetailController.swift
//  YYSwiftProject
//
//  Created by Domo on 2018/7/18.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit
// 书本详情界面

private let IMAGE_HEIGHT:CGFloat = 64
private let kNavBarBottom = WRNavigationBar.navBarBottom()
private let NAVBAR_COLORCHANGE_POINT:CGFloat = IMAGE_HEIGHT - CGFloat(kNavBarBottom)

class U17BooksDetailController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private var comicid: Int = 0
    
    private var detailStatic: DetailStaticModel?
    private var detailRealtime: DetailRealtimeModel?
    private var guessLike: GuessLikeModel?


    private let BookIntroduceCellIdentifier = "BookIntroduceCell"
    private let OtherBooksCellIdentifier = "OtherBooksCell"
    private let TicketCellIdentifier = "TicketCell"
    private let GuessLikeCellIdentifier = "GuessLikeCell"
    
    lazy var tableView : UITableView = {
        let tableView = UITableView.init(frame: CGRect(x:0, y:0, width:YYScreenWidth, height:YYScreenHeigth-44-240))
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(BookIntroduceCell.self, forCellReuseIdentifier: BookIntroduceCellIdentifier)
        tableView.register(OtherBooksCell.self, forCellReuseIdentifier: OtherBooksCellIdentifier)
        tableView.register(TicketCell.self, forCellReuseIdentifier: TicketCellIdentifier)
        tableView.register(GuessLikeCell.self, forCellReuseIdentifier: GuessLikeCellIdentifier)
        
        return tableView
    }()
    
    
    convenience init(comicid: Int, detailStatic: DetailStaticModel?,detailRealtime: DetailRealtimeModel?, guessLike: GuessLikeModel?) {
        self.init()
        self.comicid = comicid
        self.detailStatic = detailStatic
        self.detailRealtime = detailRealtime
        self.guessLike = guessLike
        self.view.addSubview(self.tableView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return detailStatic != nil ? 4 : 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (section == 1 && detailStatic?.otherWorks?.count == 0) ? 0 : 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return BookIntroduceCell.height(for: detailStatic)
        }else if indexPath.section == 3 {
            return 220
        }else {
            return 44
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return (section == 1 && detailStatic?.otherWorks?.count == 0) ? 0 : 10

    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = FooterViewColor
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell:BookIntroduceCell = tableView.dequeueReusableCell(withIdentifier: BookIntroduceCellIdentifier, for: indexPath) as! BookIntroduceCell
            cell.model = detailStatic
            return cell
        }else if indexPath.section == 1 {
            let cell:OtherBooksCell = tableView.dequeueReusableCell(withIdentifier: OtherBooksCellIdentifier, for: indexPath) as! OtherBooksCell
            cell.textLabel?.text = "其他作品"
            cell.detailTextLabel?.text = "\(detailStatic?.otherWorks?.count ?? 0)本"
            cell.detailTextLabel?.textColor = UIColor.gray
            cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 15)
            cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            return cell
        }else if indexPath.section == 2 {
            let cell:TicketCell = tableView.dequeueReusableCell(withIdentifier: TicketCellIdentifier, for: indexPath) as! TicketCell
            cell.model = self.detailRealtime
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            return cell
        }else {
            let cell:GuessLikeCell = tableView.dequeueReusableCell(withIdentifier: GuessLikeCellIdentifier, for: indexPath) as! GuessLikeCell
            cell.model = self.guessLike
           return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let vc = U17OtherBooksController(otherWorks: detailStatic?.otherWorks)
            vc.title = "其他作品"
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
     func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let nosetY : CGFloat = 0.0
        if (offsetY > NAVBAR_COLORCHANGE_POINT)
        {
            let alpha: CGFloat = 1.0
            NotificationCenter.default.post(name: NSNotification.Name("moveHeaderView"), object: self, userInfo: ["post":alpha])
        }
        else
        {
            NotificationCenter.default.post(name: NSNotification.Name("moveHeaderView"), object: self, userInfo: ["post":nosetY])
        }
    }
}
