//
//  IkonController.swift
//  YYSwiftProject
//
//  Created by Domo on 2018/7/11.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit
import SnapKit

class IkonController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource{
    
        var sizeArray: [CGSize] = {
            var sizeArray = [CGSize]()
            for i in 0 ..< 20 {
                sizeArray.append(CGSize(width: 100, height: 100 + i % 5 * 10))
            }
            return sizeArray
        }()
        // 顶部滚动图片
        lazy var bannerView = IkonBannerView()
        // 按钮
        lazy var gridView = RecommendGridView()
        // 瀑布流
        lazy var collectionView:UICollectionView = {
            let layout = YYCollectionFlowLayout()
            layout.columnCount = 2
            layout.minimumColumnSpacing = 10
            layout.minimumInteritemSpacing = 10
            //        layout.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 30, right: 40)
            layout.sectionHeaderHeight = 0
            layout.sectionFooterHeight = 0
            layout.collectionViewHeaderHeight = 450
            layout.collectionViewFooterHeight = 0
            let temcollection = UICollectionView(frame:CGRect(x:0,y:0,width:YYScreenWidth,height:YYScreenHeigth-64-49-44), collectionViewLayout: layout)
            temcollection.delegate = self
            temcollection.dataSource = self
            temcollection.backgroundColor = UIColor.white
            //        temcollection.contentInset = UIEdgeInsets(top: 10, left: 20, bottom: 30, right: 40)
            
            temcollection.register(UINib.init(nibName: "RecommendCell", bundle: nil), forCellWithReuseIdentifier: RecommendCellIdentifier)
            return temcollection
        }()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            self.view.backgroundColor = UIColor.white
            
            self.view.addSubview(collectionView)
            
            let headerView = UIView()
            headerView.frame = CGRect(x:0,y:0,width:YYScreenWidth,height:450)
            collectionView.addSubview(headerView)
            
            headerView.addSubview(self.bannerView)
            self.bannerView.snp.makeConstraints { (make) in
                make.width.equalTo(self.view)
                make.height.equalTo(350)
                make.top.equalTo(0)
                make.left.equalTo(0)
            }
            
            self.gridView = RecommendGridView.init(frame: CGRect(x:0,y:350,width:YYScreenWidth,height:100))
//            self.gridView.titleArray = ["插画榜", "人气画师", "专题精选"]
            self.gridView.gridBtnClick = {(tag) in
                print(tag)
            }
            headerView.addSubview(self.gridView)
        }
        
        public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
            return 10
        }
        
        public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendCellIdentifier, for: indexPath) as! RecommendCell
            cell.backgroundColor = UIColor.red
            return cell
        }
}
    
extension IkonController: YYCollectionFlowLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: YYCollectionFlowLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return sizeArray[indexPath.item]
    }
}

