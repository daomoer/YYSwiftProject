//
//  U17BooksGuideController.swift
//  YYSwiftProject
//
//  Created by Domo on 2018/7/18.
//  Copyright © 2018年 知言网络. All rights reserved.
//


import UIKit

private let IMAGE_HEIGHT:CGFloat = 220
private let kNavBarBottom = WRNavigationBar.navBarBottom()
private let NAVBAR_COLORCHANGE_POINT:CGFloat = IMAGE_HEIGHT - CGFloat(kNavBarBottom * 2)

// 书本目录界面
class U17BooksGuideController: UIViewController, UICollectionViewDelegateFlowLayout,UICollectionViewDataSource, UICollectionViewDelegate {
    private var comicid: Int = 0

    private var isPositive: Bool = true// 倒叙正序
    
    private var detailStatic: DetailStaticModel?
    private var detailRealtime: DetailRealtimeModel?
    
    private let GuideCollectionCellIdentifier = "GuideCollectionCell"
    private let GuideCollectionHeaderViewIdentifier = "GuideCollectionHeaderView"
    
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.sectionInset = UIEdgeInsetsMake(0, 10, 10, 10)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 10
        layout.itemSize = CGSize(width: (YYScreenWidth-30)/2, height: 40)
        let collectionView = UICollectionView.init(frame:CGRect(x:0, y:0, width:YYScreenWidth, height:YYScreenHeigth-64-44), collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.alwaysBounceVertical = true
        
        collectionView.register(GuideCollectionCell.self, forCellWithReuseIdentifier: GuideCollectionCellIdentifier)
        collectionView.register(GuideCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: GuideCollectionHeaderViewIdentifier)
        return collectionView
    }()

    convenience init(comicid: Int, detailStatic: DetailStaticModel?) {
        self.init()
        self.comicid = comicid
        self.detailStatic = detailStatic
        self.view.addSubview(self.collectionView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.detailStatic?.chapter_list?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:GuideCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: GuideCollectionCellIdentifier, for: indexPath) as! GuideCollectionCell
        if isPositive {
            cell.chapterStatic = detailStatic?.chapter_list?[indexPath.row]
        } else {
            cell.chapterStatic = detailStatic?.chapter_list?.reversed()[indexPath.row]
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = isPositive ? indexPath.row : ((detailStatic?.chapter_list?.count)! - indexPath.row - 1)
        let vc = U17ReadViewController(detailStatic: detailStatic, selectIndex: index)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.init(width: YYScreenHeigth, height:40)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            let headerView : GuideCollectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: GuideCollectionHeaderViewIdentifier, for: indexPath) as! GuideCollectionHeaderView
            headerView.backgroundColor = UIColor.white
            headerView.model = self.detailStatic
            headerView.sorkBtnClick = { [weak self] (button) in
                if self?.isPositive == true {
                    self?.isPositive = false
                }else {
                    self?.isPositive = true
                }
                self?.collectionView.reloadData()
            }
            return headerView
        }
        return UICollectionReusableView()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let nosetY : CGFloat = 0.0
        if (offsetY > NAVBAR_COLORCHANGE_POINT)
        {
            let alpha = (offsetY - NAVBAR_COLORCHANGE_POINT) / CGFloat(kNavBarBottom)
            NotificationCenter.default.post(name: NSNotification.Name("moveHeaderView"), object: self, userInfo: ["post":alpha])
        }
        else
        {
            NotificationCenter.default.post(name: NSNotification.Name("moveHeaderView"), object: self, userInfo: ["post":nosetY])
        }
    }
    
    
}

