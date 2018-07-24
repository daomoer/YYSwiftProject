//
//  U17WebViewController.swift
//  YYSwiftProject
//
//  Created by Domo on 2018/7/21.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit
import WebKit

class U17WebViewController: UIViewController {

    lazy var wkWebView : WKWebView = {
        let web = WKWebView()
        return web
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.wkWebView)
        self.wkWebView.snp.makeConstraints { (make) in
            make.width.height.equalToSuperview()
            make.center.equalToSuperview()
        }
    }
    
    convenience init(url: String?) {
        self.init()
        self.wkWebView.load(URLRequest.init(url: URL(string: url ?? "")!))
        
    }

}
