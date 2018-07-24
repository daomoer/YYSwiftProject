//
//  AppDelegate.swift
//  YYSwiftProject
//
//  Created by Domo on 2018/6/5.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit
import ESTabBarController_swift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let nav = UINavigationController.init(rootViewController: ViewController())
        self.window?.rootViewController = nav
        self.window?.makeKeyAndVisible()

        // 静态图片引导页
        self.setStaticGuidePage()
        // 动态图片引导页
        //self.setDynamicGuidePage()
        // 视频引导页
        //self.setVideoGuidePage()
        
        return true
    }
    
    func setStaticGuidePage() {
        let imageNameArray: [String] = ["lead01", "lead02", "lead03"]
        let guideView = HHGuidePageHUD.init(imageNameArray: imageNameArray, isHiddenSkipButton: false)
        self.window?.rootViewController?.view.addSubview(guideView)
    }
    
    func setDynamicGuidePage() {
        let imageNameArray: [String] = ["guideImage6.gif", "guideImage7.gif", "guideImage8.gif"]
        let guideView = HHGuidePageHUD.init(imageNameArray: imageNameArray, isHiddenSkipButton: false)
        self.window?.rootViewController?.view.addSubview(guideView)
    }
    
    func setVideoGuidePage() {
        let urlStr = Bundle.main.path(forResource: "qidong.mp4", ofType: nil)
        let videoUrl = NSURL.fileURL(withPath: urlStr!)
        let guideView = HHGuidePageHUD.init(videoURL: videoUrl, isHiddenSkipButton: false)
        self.window?.rootViewController?.view.addSubview(guideView)
    }
    


    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

