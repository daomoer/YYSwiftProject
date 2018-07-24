
//
//  YYProvider.swift
//  YYSwiftProject
//
//  Created by Domo on 2018/7/22.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import Foundation
import UIKit
import ESTabBarController_swift

enum YYProvider {
    static func customBouncesStyle() -> ESTabBarController {
        let tabBarController = ESTabBarController()
        let v1 = U17TodayViewController()
        let v2 = U17Controller()
        let v3 = U17BookRackController()
        let v4 = U17MineViewController()
        
        v1.tabBarItem = ESTabBarItem.init(YYBasicContentView(), title: "Home", image: UIImage(named: "home"), selectedImage: UIImage(named: "home_1"))
        v2.tabBarItem = ESTabBarItem.init(YYBasicContentView(), title: "Find", image: UIImage(named: "find"), selectedImage: UIImage(named: "find_1"))
        v3.tabBarItem = ESTabBarItem.init(YYBasicContentView(), title: "Favor", image: UIImage(named: "favor"), selectedImage: UIImage(named: "favor_1"))
        v4.tabBarItem = ESTabBarItem.init(YYBasicContentView(), title: "Me", image: UIImage(named: "me"), selectedImage: UIImage(named: "me_1"))
        
        let n1 = YYNavigationController.init(rootViewController: v1)
        let n2 = YYNavigationController.init(rootViewController: v2)
        let n3 = YYNavigationController.init(rootViewController: v3)
        let n4 = YYNavigationController.init(rootViewController: v4)
        
        v1.title = "今日"
        v2.title = "发现"
        v3.title = "书架"
        v4.title = "我的"
        
        tabBarController.viewControllers = [n1, n2, n3, n4]
        return tabBarController
    }
    
    static func tabbarWithNavigationStyle() -> ESTabBarController {
        let tabBarController = ESTabBarController()
        let v1 = ACGViewController()
        let v2 = YYSecondViewController()
        let v3 = YYThirdController()
        let v4 = YYFourController()
        let v5 = YYFiveController()
        
        v1.tabBarItem = ESTabBarItem.init(YYBasicContentView(), title: "Home", image: UIImage(named: "home"), selectedImage: UIImage(named: "home_1"))
        v2.tabBarItem = ESTabBarItem.init(YYBasicContentView(), title: "Find", image: UIImage(named: "find"), selectedImage: UIImage(named: "find_1"))
        v3.tabBarItem = ESTabBarItem.init(YYBasicContentView(), title: "Photo", image: UIImage(named: "photo"), selectedImage: UIImage(named: "photo_1"))
        v4.tabBarItem = ESTabBarItem.init(YYBasicContentView(), title: "Favor", image: UIImage(named: "favor"), selectedImage: UIImage(named: "favor_1"))
        v5.tabBarItem = ESTabBarItem.init(YYBasicContentView(), title: "Me", image: UIImage(named: "me"), selectedImage: UIImage(named: "me_1"))

        let n1 = YYNavigationController.init(rootViewController: v1)
        let n2 = YYNavigationController.init(rootViewController: v2)
        let n3 = YYNavigationController.init(rootViewController: v3)
        let n4 = YYNavigationController.init(rootViewController: v4)
        let n5 = YYNavigationController.init(rootViewController: v5)
        
        v1.title = "GACHA"
        v2.title = "发现"
        v3.title = "话题"
        v4.title = "消息"
        v5.title = "我的"
        
        tabBarController.viewControllers = [n1, n2, n3, n4, n5]
        
        return tabBarController
    }
    
    
    static func customIrregularityStyle(delegate: UITabBarControllerDelegate?) -> YYNavigationController {
        let tabBarController = ESTabBarController()
        tabBarController.delegate = delegate
        tabBarController.title = "Irregularity"
        tabBarController.tabBar.shadowImage = UIImage(named: "transparent")
        tabBarController.shouldHijackHandler = {
            tabbarController, viewController, index in
            if index == 2 {
                return true
            }
            return false
        }
        tabBarController.didHijackHandler = {
            [weak tabBarController] tabbarController, viewController, index in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                let alertController = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
                let takePhotoAction = UIAlertAction(title: "Take a photo", style: .default, handler: nil)
                alertController.addAction(takePhotoAction)
                let selectFromAlbumAction = UIAlertAction(title: "Select from album", style: .default, handler: nil)
                alertController.addAction(selectFromAlbumAction)
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                alertController.addAction(cancelAction)
                tabBarController?.present(alertController, animated: true, completion: nil)
            }
        }
        
        let v1 = XMLYViewController()
        let v2 = YYSecondViewController()
        let v3 = YYThirdController()
        let v4 = YYFourController()
        let v5 = YYFiveController()
        
        v1.tabBarItem = ESTabBarItem.init(YYIrregularityBasicContentView(), title: "Home", image: UIImage(named: "tabbar_me_n"), selectedImage: UIImage(named: "tabbar_me_h"))
        v2.tabBarItem = ESTabBarItem.init(YYIrregularityBasicContentView(), title: "Find", image: UIImage(named: "find"), selectedImage: UIImage(named: "find_1"))
        v3.tabBarItem = ESTabBarItem.init(YYIrregularityContentView(), title: nil, image: UIImage(named: "photo_verybig"), selectedImage: UIImage(named: "photo_verybig"))
        v4.tabBarItem = ESTabBarItem.init(YYIrregularityBasicContentView(), title: "Favor", image: UIImage(named: "favor"), selectedImage: UIImage(named: "favor_1"))
        v5.tabBarItem = ESTabBarItem.init(YYIrregularityBasicContentView(), title: "Me", image: UIImage(named: "me"), selectedImage: UIImage(named: "me_1"))
        
        tabBarController.viewControllers = [v1, v2, v3, v4, v5]
        
        let navigationController = YYNavigationController.init(rootViewController: tabBarController)
        tabBarController.title = "喜玛拉雅"
        return navigationController
    }
    

}
