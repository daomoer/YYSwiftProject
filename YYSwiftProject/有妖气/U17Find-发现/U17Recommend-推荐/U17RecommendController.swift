//
//  U17RecommendController.swift
//  YYSwiftProject
//
//  Created by Domo on 2018/7/11.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit

// 推荐界面
class U17RecommendController: UIViewController ,UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    private var galleryItems = [GalleryItemModel]()
    private var TextItems = [TextItemModel]()
    private var comicLists = [ComicListModel]()

    
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
        
        
        collection.uHead = URefreshHeader { [weak self] in self?.loadData() }
        collection.uFoot = URefreshDiscoverFooter()
        return collection
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.lightGray
        self.view.addSubview(self.collectionView)
        loadData()
    }
    
    private func loadData(){
        ApiLoadingProvider.request(UApi.boutiqueList(sexType: 1), model: BoutiqueListModel.self) { [weak self] (returnData) in
            self?.galleryItems = returnData?.galleryItems ?? []
            self?.TextItems = returnData?.textItems ?? []
            self?.comicLists = returnData?.comicLists ?? []
            
            self?.collectionView.uHead.endRefreshing()
            
            self?.collectionView.reloadData()
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return comicLists.count
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
        let comicList = comicLists[indexPath.section]
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: U17BannerViewCellIdentifier, for: indexPath) as! U17BannerViewCell
            cell.imagePaths = self.galleryItems.filter { $0.cover != nil }.map { $0.cover! }
            cell.comicListModel = comicLists[indexPath.section]
            cell.u17BannerClick  = {[weak self](index) in
                let item = self?.galleryItems[index]
                if item?.linkType == 2 {
                    guard let url = item?.ext?.flatMap({ return $0.key == "url" ? $0.val : nil }).joined() else { return }
                     let vc = U17WebViewController(url: url)
                    self?.navigationController?.pushViewController(vc, animated: true)
                } else {
                    guard let comicIdString = item?.ext?.flatMap({ return $0.key == "comicId" ? $0.val : nil }).joined(),
                        let comicId = Int(comicIdString) else { return }
                    let vc = U17BooksViewController(comicid: comicId, titleStr:"北极")
                   self?.navigationController?.pushViewController(vc, animated: true)
                }
            }
            
            cell.u17GridBtnClick = {[weak self](index) in
                let model:ComicModel = comicList.comics![index]
                
                let vc = U17RankListViewController(argCon: model.argCon,
                                                       argName: model.argName,
                                                       argValue: model.argValue)
                    vc.title = model.itemTitle
                    self?.navigationController?.pushViewController(vc, animated: true)
            }
            return cell
        } else if indexPath.section == 1 || indexPath.section == 2{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlcrossRecommendCellIdentifier, for: indexPath) as! AlcrossRecommendCell
            cell.model = comicList.comics?[indexPath.row]
            cell.backgroundColor = UIColor.white
            return cell
        } else if indexPath.section == 3 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: U17RecommendTopicCellIdentifier, for: indexPath) as! U17RecommendTopicCell
            cell.model = comicList.comics?[indexPath.row]
            return cell
        }
        else if indexPath.section == 4 || indexPath.section == 6 || indexPath.section == 8 || indexPath.section == 9 || indexPath.section == 10{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VerticalRecommendCellIdentifier, for: indexPath) as! VerticalRecommendCell
            if comicList.comics?.count == 3{
                cell.model = comicList.comics?[indexPath.row]
            }
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlcrossRecommendCellIdentifier, for: indexPath) as! AlcrossRecommendCell
            cell.backgroundColor = UIColor.white
            if comicList.comics?.count == 2 {
                cell.model = comicList.comics?[indexPath.row]
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            return
        }else {
        let comicList = comicLists[indexPath.section]
        guard let item = comicList.comics?[indexPath.row] else { return }
        let vc = U17BooksViewController(comicid:item.comicId,titleStr:item.name)
        self.navigationController?.pushViewController(vc, animated: true)
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
            return CGSize.init(width:YYScreenWidth,height:260)
        }else if indexPath.section == 1 || indexPath.section == 2 {
            return CGSize.init(width:YYScreenWidth/2-3,height:150)
        }else if indexPath.section == 3{
            return CGSize.init(width:YYScreenWidth/2-3,height:120)
        }else if indexPath.section == 4 || indexPath.section == 6 || indexPath.section == 9 || indexPath.section == 10{
            return CGSize.init(width:YYScreenWidth/3-4,height:220)
        }else if indexPath.section == 8{
            return .zero
        }else {
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
            let comicList:ComicListModel = comicLists[indexPath.section]
            if (comicList.itemTitle != nil) {
                headerView.titleL.text = comicList.itemTitle
                headerView.imageView.kf.setImage(with:URL(string:comicList.newTitleIconUrl!))
            }
            // 每个分区header右侧点击更多按钮
            headerView.headerMoreBtnClick = {[weak self]() in
                if indexPath.section == 3 {
                
                }else if indexPath.section == 5 {

                }else if indexPath.section == 7 {
                    let vc = U17WebViewController(url: "http://m.u17.com/wap/cartoon/list")
                    vc.title = "动画"
                    self?.navigationController?.pushViewController(vc, animated: true)
                }else {
                    let comicList:ComicListModel = (self?.comicLists[indexPath.section])!
                    let vc = U17MoreBooksController(argCon: comicList.argCon,
                                                       argName:comicList.argName,
                                                       argValue:comicList.argValue)
                    vc.title = comicList.itemTitle
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
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
