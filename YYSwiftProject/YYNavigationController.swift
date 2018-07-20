//
//  YYNavigationController.swift
//  YYSwiftProject
//
//  Created by Domo on 2018/7/19.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit

class YYNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension YYNavigationController
{
    override func pushViewController(_ viewController: UIViewController, animated: Bool)
    {
        if childViewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
}
