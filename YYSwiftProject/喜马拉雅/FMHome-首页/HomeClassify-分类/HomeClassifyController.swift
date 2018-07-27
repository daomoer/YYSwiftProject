//
//  HomeClassifyController.swift
//  YYSwiftProject
//
//  Created by Domo on 2018/7/24.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit
import HandyJSON
import SwiftyJSON

/// 首页分类控制器
class HomeClassifyController: HomeBaseViewController {
    private var classifyModel:[ClassifyModel]?
    
    private let CellIdentifier = "HomeClassifyCell"
    private let HomeClassifyFooterViewID = "HomeClassifyFooterView"
    private let HomeClassifyHeaderViewID = "HomeClassifyHeaderView"
    
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let collection = UICollectionView.init(frame: CGRect(x:0, y:0, width:YYScreenWidth, height:YYScreenHeigth-49), collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.register(HomeClassifyCell.self, forCellWithReuseIdentifier: CellIdentifier )
        collection.register(HomeClassifyHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: HomeClassifyHeaderViewID)
        
        collection.register(HomeClassifyFooterView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: HomeClassifyFooterViewID)
        
        collection.backgroundColor = FooterViewColor
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.collectionView)
        loadData()
    }
    
    func loadData(){
        //首页分类接口请求
        HomeClassifProvider.request(.classifyList) { result in
            if case let .success(response) = result {
                //解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                
                if let mappedObject = JSONDeserializer<HomeClassifyModel>.deserializeFrom(json: json.description) { // 从字符串转换为对象实例
                    self.classifyModel = mappedObject.list
                    self.collectionView.reloadData()
                }
            }
        }
    }
}

extension HomeClassifyController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.classifyModel?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.classifyModel?[section].itemList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:HomeClassifyCell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier, for: indexPath) as! HomeClassifyCell
        cell.backgroundColor = UIColor.white
        cell.layer.masksToBounds =  true
        cell.layer.cornerRadius = 4.0
        cell.layer.borderColor = UIColor.init(red: 220/255.0, green: 220/255.0, blue: 220/255.0, alpha: 1).cgColor
        cell.layer.borderWidth = 0.5
        cell.itemModel = self.classifyModel?[indexPath.section].itemList![indexPath.row]
//        cell.indexPath = indexPath
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    //每个分区的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 2.5, 0, 2.5);
    }
    
    //最小 item 间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    //最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2.5;
    }
    
    //item 的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 || indexPath.section == 1 || indexPath.section == 2 {
            return CGSize.init(width:(YYScreenWidth-10)/4,height:50)
        }else {
            return CGSize.init(width:(YYScreenWidth-7.5)/3,height:50)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 || section == 1 || section == 2 {
            return .zero
        }else {
            return CGSize.init(width: YYScreenHeigth, height:30)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize.init(width: YYScreenWidth, height: 10.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            let headerView : HomeClassifyHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: HomeClassifyHeaderViewID, for: indexPath) as! HomeClassifyHeaderView
            headerView.titleString = self.classifyModel?[indexPath.section].groupName
            return headerView
        }else if kind == UICollectionElementKindSectionFooter {
            let footerView : HomeClassifyFooterView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: HomeClassifyFooterViewID, for: indexPath) as! HomeClassifyFooterView
            return footerView
        }
        return UICollectionReusableView()
    }
}
