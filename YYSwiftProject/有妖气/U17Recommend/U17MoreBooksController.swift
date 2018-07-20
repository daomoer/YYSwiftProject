//
//  U17MoreBooksController.swift
//  YYSwiftProject
//
//  Created by Domo on 2018/7/20.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit
import HandyJSON

// 更多推荐书籍界面
class U17MoreBooksController: UIViewController ,UITableViewDataSource, UITableViewDelegate {

        private var argCon: Int = 0
        private var argName: String?
        private var argValue: Int = 0
        private var page: Int = 1
        private var spinnerName: String = ""
        
        private var comicList = [ComicModel]()
        
        lazy var tableView:UITableView = {
            let tableView = UITableView.init(frame: CGRect(x:0,y:0,width:YYScreenWidth, height:YYScreenHeigth), style: .plain)
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(U17YTDRankCell.self, forCellReuseIdentifier: "U17YTDRankCell")
            
            tableView.uHead = URefreshHeader { [weak self] in self?.loadData(more: false) }
            tableView.uFoot = URefreshFooter { [weak self] in self?.loadData(more: true) }
            return tableView
        }()
        
        convenience init(argCon: Int = 0, argName: String?, argValue: Int = 0) {
            self.init()
            self.argCon = argCon
            self.argName = argName
            self.argValue = argValue
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            loadData(more: false)
            self.view.addSubview(self.tableView)
        }
        
        @objc private func loadData(more: Bool) {
            page = (more ? ( page + 1) : 1)
            ApiLoadingProvider.request(UApi.comicList(argCon: argCon, argName: argName ?? "", argValue: argValue, page: page),
                                       model: ComicListModel.self) { [weak self] (returnData) in
                                        self?.tableView.uHead.endRefreshing()
                                        if returnData?.hasMore == false {
                                            self?.tableView.uFoot.endRefreshingWithNoMoreData()
                                        } else {
                                            self?.tableView.uFoot.endRefreshing()
                                        }
                                        
                                        if more == false { self?.comicList.removeAll() }
                                        self?.comicList.append(contentsOf: returnData?.comics ?? [])
                                        self?.tableView.reloadData()
                                        
                                        guard let defaultParameters = returnData?.defaultParameters else { return }
                                        self?.argCon = defaultParameters.defaultArgCon
                                        guard let defaultConTagType = defaultParameters.defaultConTagType else { return }
                                        self?.spinnerName = defaultConTagType
            }
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return comicList.count
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 165
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell:U17YTDRankCell = tableView.dequeueReusableCell(withIdentifier: "U17YTDRankCell", for: indexPath) as! U17YTDRankCell
            cell.updateModel = comicList[indexPath.row]
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            cell.spinnerName = self.spinnerName
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let model = comicList[indexPath.row]
            let vc = U17BooksViewController(comicid: model.comicId,titleStr:model.name)
            navigationController?.pushViewController(vc, animated: true)
        }
        
        
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
}
