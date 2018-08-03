//
//  ViewController.swift
//  YYSwiftProject
//
//  Created by Domo on 2018/6/5.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private lazy var tableView : UITableView = {
        let tabView = UITableView.init(frame: self.view.frame, style: UITableViewStyle.plain)
        tabView.delegate = self
        tabView.dataSource = self
        tabView.register(UITableViewCell.self, forCellReuseIdentifier: "CellIdentifier")
        return tabView
    }()
    
    private let titleArray = ["有妖气漫画", "网易二次元"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "YYSwiftProject"
        self.view.addSubview(self.tableView)
    }
}


extension ViewController : UITableViewDelegate, UITableViewDataSource, UITabBarControllerDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath) 
        cell.textLabel?.text = titleArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.present(YYProvider.customBouncesStyle(), animated: true, completion: nil)
        default:
            self.present(YYProvider.tabbarWithNavigationStyle(), animated: true, completion: nil)
        }
    }
}
