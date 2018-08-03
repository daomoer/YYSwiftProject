//
//  U17HistoryController.swift
//  YYSwiftProject
//
//  Created by Domo on 2018/7/29.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit

class U17HistoryController: UIViewController {
    private var historyList = [ReadHistoryModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    func loadData(){
        ApiLoadingProvider.request(UApi.historyList, model: ReadHistoryModel.self) { [weak self] (returnData) in
//           self?.historyList = returnData?.dayDataList ?? []
        }
    }
}
