//
//  U17VIPController.swift
//  YYSwiftProject
//
//  Created by Domo on 2018/7/11.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit

class U17VIPController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout{
    private let CellIdentifier = "VIPAndSubCell"
    private let U17RecommendHeaderViewIdentifier = "U17RecommendHeaderView"
    private let U17FooterViewIdentifier = "U17FooterView"

    private var vipList = [ComicListModel]()
    
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let collection = UICollectionView.init(frame: CGRect(x:0, y:0, width:YYScreenWidth, height:YYScreenHeigth-64-49), collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.register(UINib.init(nibName: "VIPAndSubCell", bundle: nil), forCellWithReuseIdentifier: CellIdentifier)
        collection.register(U17RecommendHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: U17RecommendHeaderViewIdentifier)
        
        collection.register(U17FooterView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: U17FooterViewIdentifier)

        collection.uHead = URefreshHeader{ [weak self] in self?.loadData() }
        collection.uFoot = URefreshTipKissFooter(with: "VIP用户专享\nVIP用户可以免费阅读全部漫画哦~")
        
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
        ApiLoadingProvider.request(UApi.vipList, model: VipListModel.self) { (returnData) in
            self.collectionView.uHead.endRefreshing()
            self.vipList = returnData?.newVipList ?? []
            self.collectionView.reloadData()
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return vipList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let comicList = vipList[section]
        return comicList.comics?.count ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:VIPAndSubCell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier, for: indexPath) as! VIPAndSubCell
        let comicList = vipList[indexPath.section]
        cell.model = comicList.comics?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let comicList = vipList[indexPath.section]
        guard let item = comicList.comics?[indexPath.row] else { return }
        let vc = U17BooksViewController(comicid:item.comicId,titleStr:item.name)
        self.navigationController?.pushViewController(vc, animated: true)
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
            return CGSize.init(width:YYScreenWidth/3-4,height:220)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
            return CGSize.init(width: YYScreenHeigth, height:40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize.init(width: YYScreenWidth, height: 10.0)
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            let headerView : U17RecommendHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: U17RecommendHeaderViewIdentifier, for: indexPath) as! U17RecommendHeaderView
            let comicList = vipList[indexPath.section]
            headerView.imageView.kf.setImage(with: URL(string:comicList.titleIconUrl!))
            headerView.titleL.text = comicList.itemTitle
            headerView.moreBtn.isHidden = !comicList.canMore
            headerView.headerMoreBtnClick = {[weak self]() in
                let comicList:ComicListModel = (self?.vipList[indexPath.section])!
                let vc = U17MoreBooksController(argCon: comicList.argCon,
                                                argName:comicList.argName,
                                                argValue:comicList.argValue)
                vc.title = comicList.itemTitle
                self?.navigationController?.pushViewController(vc, animated: true)
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
        // Dispose of any resources that can be recreated.
    }

}
