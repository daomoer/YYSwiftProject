//
//  U17RankController.swift
//  YYSwiftProject
//
//  Created by Domo on 2018/7/11.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit

class U17RankController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout{
        private let CellIdentifier = "U17RankCell"
        private let U17FooterViewIdentifier = "U17FooterView"
    
        private var rankList = [RankingModel]()

        lazy var collectionView : UICollectionView = {
            let layout = UICollectionViewFlowLayout.init()
            let collection = UICollectionView.init(frame: CGRect(x:0, y:0, width:YYScreenWidth, height:YYScreenHeigth-64-49), collectionViewLayout: layout)
            collection.delegate = self
            collection.dataSource = self
            collection.register(U17RankCell.self, forCellWithReuseIdentifier: CellIdentifier)
            collection.register(U17FooterView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: U17FooterViewIdentifier)

            collection.uHead = URefreshHeader{ [weak self] in self?.loadData() }
            collection.backgroundColor = UIColor.white
            return collection
        }()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            self.view.backgroundColor = UIColor.white
            self.view.addSubview(self.collectionView)
            loadData()
        }
    
        private func loadData(){
            ApiLoadingProvider.request(UApi.rankList, model: RankinglistModel.self) { (returnData) in
                self.collectionView.uHead.endRefreshing()
                self.rankList = returnData?.rankinglist ?? []
                self.collectionView.reloadData()
            }
        }
        
        func numberOfSections(in collectionView: UICollectionView) -> Int {
            return rankList.count
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 1
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell:U17RankCell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier, for: indexPath) as! U17RankCell
            cell.model = rankList[indexPath.section]
            return cell
        }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = rankList[indexPath.row]
        let vc = U17RankListViewController(argCon: model.argCon,
                                          argName: model.argName,
                                          argValue: model.argValue)
        vc.title = "\(model.title!)榜"
        navigationController?.pushViewController(vc, animated: true)
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
            return CGSize.init(width:YYScreenWidth,height:160)
        }
    
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
            return CGSize.init(width: YYScreenWidth, height: 10.0)
        }
    
        func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
          if kind == UICollectionElementKindSectionFooter {
                let footerView : U17FooterView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: U17FooterViewIdentifier, for: indexPath) as! U17FooterView
                return footerView
            }
            return UICollectionReusableView()
        }
    }
