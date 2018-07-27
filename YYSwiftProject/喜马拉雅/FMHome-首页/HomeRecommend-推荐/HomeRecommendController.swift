//
//  HomeRecommendController.swift
//  YYSwiftProject
//
//  Created by Domo on 2018/7/24.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON
/// 首页推荐控制器
class HomeRecommendController: HomeBaseViewController {
    private var fmhomeRecommendModel:FMHomeRecommendModel?
    private var homeRecommendList:[HomeRecommendModel]?
    
    private var focus:FocusModel?
    private var square: SquareModel?
    private var topBuzz: TopBuzzModel?
    private var guessYouLike: GuessYouLikeModel?
    private var paidCategory: PaidCategoryModel?
    private var categoriesForShort: CategoriesForShortModel?
    private var playlist: PlaylistModel?
    private var oneKeyListen: OneKeyListenModel?
    private var categoriesForLong: CategoriesForLongModel?
    private var live: LiveModel?
    private var categoriesForExplore: CategoriesForExploreModel?
    private var cityCategory: CityCategoryModel?
    
    private let FMRecommendHeaderViewID     = "FMRecommendHeaderView"
    private let FMRecommendFooterViewID     = "FMRecommendFooterView"

    private let FMRecommendHeaderCellID     = "FMRecommendHeaderCell"
    private let FMRecommendGuessLikeCellID  = "FMRecommendGuessLikeCell"
    private let FMHotAudiobookCellID        = "FMHotAudiobookCell"
    private let FMAdvertCellID              = "FMAdvertCell"
    private let FMOneKeyListenCellID        = "FMOneKeyListenCell"
    private let FMRecommendForYouCellID     = "FMRecommendForYouCell"

    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let collection = UICollectionView.init(frame:.zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = UIColor.white
        
        collection.register(FMRecommendHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: FMRecommendHeaderCellID)
        collection.register(FMRecommendFooterView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: FMRecommendFooterViewID)

        collection.register(FMRecommendHeaderCell.self, forCellWithReuseIdentifier: FMRecommendHeaderCellID)
        collection.register(FMRecommendGuessLikeCell.self, forCellWithReuseIdentifier: FMRecommendGuessLikeCellID)
        collection.register(FMHotAudiobookCell.self, forCellWithReuseIdentifier: FMHotAudiobookCellID)
        collection.register(FMAdvertCell.self, forCellWithReuseIdentifier: FMAdvertCellID)
        collection.register(FMOneKeyListenCell.self, forCellWithReuseIdentifier: FMOneKeyListenCellID)
        collection.register(FMRecommendForYouCell.self, forCellWithReuseIdentifier: FMRecommendForYouCellID)

        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.left.right.top.height.equalToSuperview()
        }
        loadData()
    }
    
    
    
    
    
    func loadData(){
//        //首页推荐接口请求
        FMRecommendProvider.request(.recommendList) { result in
                        if case let .success(response) = result {
                //解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if let mappedObject = JSONDeserializer<FMHomeRecommendModel>.deserializeFrom(json: json.description) { // 从字符串转换为对象实例
                    self.fmhomeRecommendModel = mappedObject
                    self.homeRecommendList = mappedObject.list
                    if let focus = JSONDeserializer<FocusModel>.deserializeFrom(json: json["list"][0]["list"][0].description) {
                        self.focus = focus
                    }
                    self.collectionView.reloadData()
                }
            }
        }
    }
}

extension HomeRecommendController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.homeRecommendList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell:FMRecommendHeaderCell = collectionView.dequeueReusableCell(withReuseIdentifier: FMRecommendHeaderCellID, for: indexPath) as! FMRecommendHeaderCell
            
            return cell
        }else if indexPath.section == 1 || indexPath.section == 2 || indexPath.section == 9 || indexPath.section == 10 || indexPath.section == 12 || indexPath.section == 14{
            let cell:FMRecommendGuessLikeCell = collectionView.dequeueReusableCell(withReuseIdentifier: FMRecommendGuessLikeCellID, for: indexPath) as! FMRecommendGuessLikeCell
            return cell
        }else if indexPath.section == 3 || indexPath.section == 4 || indexPath.section == 6 || indexPath.section == 8 || indexPath.section == 13{
            let cell:FMHotAudiobookCell = collectionView.dequeueReusableCell(withReuseIdentifier: FMHotAudiobookCellID, for: indexPath) as! FMHotAudiobookCell
            return cell
        }else if indexPath.section == 5 || indexPath.section == 11{
            let cell:FMAdvertCell = collectionView.dequeueReusableCell(withReuseIdentifier: FMAdvertCellID, for: indexPath) as! FMAdvertCell
            return cell
        }else if indexPath.section == 7{
            let cell:FMOneKeyListenCell = collectionView.dequeueReusableCell(withReuseIdentifier: FMOneKeyListenCellID, for: indexPath) as! FMOneKeyListenCell
            return cell
        }else {
            let cell:FMRecommendForYouCell = collectionView.dequeueReusableCell(withReuseIdentifier: FMRecommendForYouCellID, for: indexPath) as! FMRecommendForYouCell
            return cell
        }
        
    }
    
    //每个分区的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }

    //最小 item 间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }

    //最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    //item 的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if  indexPath.section == 0{
            return CGSize.init(width:YYScreenWidth,height:440)
        }else if indexPath.section == 1 || indexPath.section == 2 || indexPath.section == 9 || indexPath.section == 10 || indexPath.section == 12 || indexPath.section == 14 {
            return CGSize.init(width:YYScreenWidth,height:480)
        }else if indexPath.section == 3 || indexPath.section == 4 || indexPath.section == 6 || indexPath.section == 8 || indexPath.section == 13{
            return CGSize.init(width:YYScreenWidth,height:460)
        }else if indexPath.section == 5 || indexPath.section == 11{
            return CGSize.init(width:YYScreenWidth,height:240)
        }else if indexPath.section == 7 {
            return CGSize.init(width:YYScreenWidth,height:180)
        }else{
            return CGSize.init(width:YYScreenWidth,height:3000)

        }
//            else if indexPath.section == 3{
//            return CGSize.init(width:YYScreenWidth/2-3,height:120)
//        }else if indexPath.section == 4 || indexPath.section == 6 || indexPath.section == 8 || indexPath.section == 9 || indexPath.section == 10{
//            return CGSize.init(width:YYScreenWidth/3-4,height:220)
//        }else{
//            return CGSize.init(width:YYScreenWidth/2-3,height:150)
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 || section == 5 {
            return CGSize.zero
        }else {
            return CGSize.init(width: YYScreenHeigth, height:40)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize.init(width: YYScreenWidth, height: 10.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            let headerView : FMRecommendHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: FMRecommendHeaderCellID, for: indexPath) as! FMRecommendHeaderView
            return headerView
        }else if kind == UICollectionElementKindSectionFooter {
            let footerView : FMRecommendFooterView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: FMRecommendFooterViewID, for: indexPath) as! FMRecommendFooterView
            return footerView
        }
        return UICollectionReusableView()
    }
}
