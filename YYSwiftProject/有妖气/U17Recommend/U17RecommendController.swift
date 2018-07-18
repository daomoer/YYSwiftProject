//
//  U17RecommendController.swift
//  YYSwiftProject
//
//  Created by Domo on 2018/7/11.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit

class U17RecommendController: UIViewController ,UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    private let AlcrossRecommendCellIdentifier = "AlcrossRecommendCell"
    private let VerticalRecommendCellIdentifier = "VerticalRecommendCell"
    private let U17RecommendTopicCellIdentifier = "U17RecommendTopicCell"
    private let U17BannerViewCellIdentifier = "U17BannerViewCell"
    private let U17RecommendHeaderViewIdentifier = "U17RecommendHeaderView"
    private let U17FooterViewIdentifier = "U17FooterView"

    
    
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let collection = UICollectionView.init(frame: CGRect(x:0, y: 0 ,width: YYScreenWidth, height:YYScreenHeigth-64-49), collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = UIColor.white
        collection.register(U17BannerViewCell.self, forCellWithReuseIdentifier: U17BannerViewCellIdentifier)
        collection.register(UINib.init(nibName: "AlcrossRecommendCell", bundle: nil), forCellWithReuseIdentifier: AlcrossRecommendCellIdentifier)
        collection.register(UINib.init(nibName: "VerticalRecommendCell", bundle: nil), forCellWithReuseIdentifier: VerticalRecommendCellIdentifier)
        collection.register(UINib.init(nibName: "U17RecommendTopicCell", bundle: nil), forCellWithReuseIdentifier: U17RecommendTopicCellIdentifier)
        collection.register(U17RecommendHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: U17RecommendHeaderViewIdentifier)
        collection.register(U17FooterView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: U17FooterViewIdentifier)
        
        return collection
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.lightGray
        self.view.addSubview(self.collectionView)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 11
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else if section == 1 || section == 2 || section == 3{
            return 4
        }else if section == 4 || section == 6 || section == 8 || section == 9 || section == 10{
            return 3
        }else {
            return 2
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: U17BannerViewCellIdentifier, for: indexPath) as! U17BannerViewCell
            return cell
        } else if indexPath.section == 1 || indexPath.section == 2{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlcrossRecommendCellIdentifier, for: indexPath) as! AlcrossRecommendCell
            cell.backgroundColor = UIColor.white
            return cell
        } else if indexPath.section == 3 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: U17RecommendTopicCellIdentifier, for: indexPath) as! U17RecommendTopicCell
            return cell
        }
        else if indexPath.section == 4 || indexPath.section == 6 || indexPath.section == 8 || indexPath.section == 9 || indexPath.section == 10{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VerticalRecommendCellIdentifier, for: indexPath) as! VerticalRecommendCell
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlcrossRecommendCellIdentifier, for: indexPath) as! AlcrossRecommendCell
            cell.backgroundColor = UIColor.white
            return cell
        }
    }
    
    //每个分区的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    
    //最小 item 间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 6;
    }
    
    //最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 6;
    }
    
    //item 的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if  indexPath.section == 0{
            return CGSize.init(width:YYScreenWidth,height:240)
        }else if indexPath.section == 1 || indexPath.section == 2 {
            return CGSize.init(width:YYScreenWidth/2-3,height:150)
        }else if indexPath.section == 3{
            return CGSize.init(width:YYScreenWidth/2-3,height:120)
        }else if indexPath.section == 4 || indexPath.section == 6 || indexPath.section == 8 || indexPath.section == 9 || indexPath.section == 10{
            return CGSize.init(width:YYScreenWidth/3-4,height:220)
        }else{
            return CGSize.init(width:YYScreenWidth/2-3,height:150)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
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
            let headerView : U17RecommendHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: U17RecommendHeaderViewIdentifier, for: indexPath) as! U17RecommendHeaderView
            headerView.headerMoreBtnClick = {[weak self]() in
                let bookVC = U17BooksViewController()
                self?.navigationController?.pushViewController(bookVC, animated: true)
            }
            return headerView
        }else if kind == UICollectionElementKindSectionFooter {
            let footerView : U17FooterView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: U17FooterViewIdentifier, for: indexPath) as! U17FooterView
            return footerView
        }
        return UICollectionReusableView()
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
