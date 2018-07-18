//
//  RecommendController.swift
//  YYSwiftProject
//
//  Created by Domo on 2018/7/11.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit
import SnapKit

class RecommendController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    let BannerIdentifier = "RecommendBannerViewCell"
    let HotTopicIdentifier = "RecommendHotTopicCell"
    let HotCircleIdentifier = "RecommendHotCircleCell"
    let RecommIdentifier = "RecommendHotRecommCell"

    let headerHeight:CGFloat = 40
    let footerHeight:CGFloat = 50
    
    lazy var tableView : UITableView = {
        let tbView = UITableView.init(frame:CGRect(x:0, y:0, width:YYScreenWidth, height:YYScreenHeigth-64-49-44),style: .grouped)
        tbView.delegate = self
        tbView.dataSource = self
        tbView.register(RecommendBannerViewCell.self, forCellReuseIdentifier: BannerIdentifier)
        tbView.register(RecommendHotTopicCell.self, forCellReuseIdentifier: HotTopicIdentifier)
        tbView.register(RecommendHotCircleCell.self, forCellReuseIdentifier: HotCircleIdentifier)
        tbView.register(RecommendHotRecommCell.self, forCellReuseIdentifier: RecommIdentifier)
        
        return tbView
    }()
    ////////////////////////////// 第 二 三 四 分区头视图  \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
    lazy var hotTopicHeaderView : RecommendHeaderView = {
        let hot = RecommendHeaderView.init(frame: CGRect(x:0, y:0, width: Int(YYScreenHeigth), height:Int(headerHeight)))
        hot.imageView.image = UIImage(named:"discovery_icon_glist~iphone")
        hot.titleL.text = "热门专题"
        hot.changeBtn.isHidden = true
        return hot
    }()
    
    lazy var hotCircleHeaderView : RecommendHeaderView = {
        let hot = RecommendHeaderView.init(frame: CGRect(x:0, y:0, width: Int(YYScreenHeigth), height:Int(headerHeight)))
        hot.imageView.image = UIImage(named:"discovery_icon_circle~iphone")
        hot.titleL.text = "热门圈子"
        hot.changeBtn.isHidden = true
        return hot
    }()
    
    lazy var hotRecommHeaderView : RecommendHeaderView = {
        let hot = RecommendHeaderView.init(frame: CGRect(x:0, y:0, width: Int(YYScreenHeigth), height:Int(headerHeight)))
        hot.imageView.image = UIImage(named:"hot_illustration_title")
        hot.titleL.text = "GACHA热推"
        hot.headerChangeBtnClick = {[weak self](isSelected) in
            
        }
        return hot
    }()
    
    ////////////////////////////// 第 二 三  分区尾视图  \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
    lazy var hotTopicFooterView : RecommendFooterView = {
        let hot = RecommendFooterView.init(frame: CGRect(x:0, y:0, width: Int(YYScreenHeigth), height:Int(footerHeight)))
       hot.title = "更多专题"
        return hot
    }()
    
    lazy var hotCricleFooterView : RecommendFooterView = {
        let hot = RecommendFooterView.init(frame: CGRect(x:0, y:0, width: Int(YYScreenHeigth), height:Int(footerHeight)))
       hot.title = "更多圈子"
        return hot
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.tableView)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section==0 {
            return 1
        }else if section == 1 || section == 2 {
            return 2
        }else if section == 3 {
            return 1
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section==0 {
            return 150
        }else if indexPath.section == 1 {
            return 380
        }else if indexPath.section == 2 {
            return 400
        }else if indexPath.section == 3 {
            return 800
        }else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return nil
        } else if section == 1 {
            return self.hotTopicHeaderView
        } else if section == 2 {
            return self.hotCircleHeaderView
        } else {
            return self.hotRecommHeaderView
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 0 {
            return nil
        } else if section == 1 {
            return self.hotTopicFooterView
        } else if section == 2 {
            return self.hotCricleFooterView
        } else {
            return nil
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0.01
        } else {
            return headerHeight
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 || section == 3 {
            return 0.01
        }else {
            return footerHeight
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: BannerIdentifier, for: indexPath) as! RecommendBannerViewCell
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            return cell
        }else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: HotTopicIdentifier, for: indexPath) as! RecommendHotTopicCell
            cell.backgroundColor = UIColor.lightGray
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            return cell
        }else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: HotCircleIdentifier, for: indexPath) as! RecommendHotCircleCell
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: RecommIdentifier, for: indexPath) as! RecommendHotRecommCell
            cell.backgroundColor = UIColor.lightGray
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = U17BooksViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
