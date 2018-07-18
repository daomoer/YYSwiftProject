//
//  U17RankListViewController.swift
//  YYSwiftProject
//
//  Created by Domo on 2018/7/17.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit

class U17RankListViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    private let CellIdentifier = "U17YTDRankCell"
    
    lazy var tableView:UITableView = {
        let tableView = UITableView.init(frame: CGRect(x:0,y:0,width:YYScreenWidth, height:YYScreenHeigth), style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(U17YTDRankCell.self, forCellReuseIdentifier: CellIdentifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.tableView)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:U17YTDRankCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier, for: indexPath) as! U17YTDRankCell
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
