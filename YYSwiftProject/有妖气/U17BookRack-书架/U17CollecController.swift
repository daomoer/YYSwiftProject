//
//  U17CollectController.swift
//  YYSwiftProject
//
//  Created by Domo on 2018/7/29.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit

/// 书架收藏界面
class U17CollectController: UIViewController {
    private var favList = [FavList]()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    func loadData(){
        ApiLoadingProvider.request(UApi.favList, model: favListModel.self) {[weak self]
            (returnData) in
           self?.favList = returnData?.favList ?? []
        }
    }

}
