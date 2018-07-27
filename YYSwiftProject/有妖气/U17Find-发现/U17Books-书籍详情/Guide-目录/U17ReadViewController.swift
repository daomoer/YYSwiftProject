//
//  U17ReadViewController.swift
//  YYSwiftProject
//
//  Created by Domo on 2018/7/21.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit

class U17ReadViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private var chapterList = [ChapterModel]()
    
    private var detailStatic: DetailStaticModel?
    
    private var selectIndex: Int = 0
    
    private var previousIndex: Int = 0
    
    private var nextIndex: Int = 0
    
    private lazy var collectionView: UICollectionView = {
        let lt = UICollectionViewFlowLayout()
        lt.sectionInset = UIEdgeInsetsMake(0, 10, 10, 10)
        lt.itemSize = CGSize(width: YYScreenWidth, height: 260)
        lt.minimumLineSpacing = 10
        lt.minimumInteritemSpacing = 10
        let cw = UICollectionView(frame: CGRect(x:0,y:0,width:YYScreenWidth,height:YYScreenHeigth), collectionViewLayout: lt)
        cw.backgroundColor = FooterViewColor
        cw.delegate = self
        cw.dataSource = self
        cw.register(U17ReadCell.self, forCellWithReuseIdentifier: "Cell")
        cw.uHead = URefreshAutoHeader { [weak self] in
            let previousIndex = self?.previousIndex ?? 0
            self?.loadData(with: previousIndex, isPreious: true, needClear: false, finished: { [weak self]  (finish) in
                self?.previousIndex = previousIndex - 1
            })
        }
        cw.uFoot = URefreshAutoFooter { [weak self] in
            let nextIndex = self?.nextIndex ?? 0
            self?.loadData(with: nextIndex, isPreious: false, needClear: false, finished: { [weak self]  (finish) in
                self?.nextIndex = nextIndex + 1
            })
        }
        return cw
    }()
    
    convenience init(detailStatic: DetailStaticModel?, selectIndex: Int) {
        self.init()
        self.detailStatic = detailStatic
        self.selectIndex = selectIndex
        self.previousIndex = selectIndex - 1
        self.nextIndex = selectIndex + 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.collectionView)
        loadData(with: selectIndex, isPreious: false, needClear: false)
    }
    
    func loadData(with index: Int, isPreious: Bool, needClear: Bool, finished: ((_ finished: Bool) -> Void)? = nil) {
        guard let detailStatic = detailStatic else { return }
//        self.text = detailStatic.comic?.name
        
        if index <= -1 {
            collectionView.uHead.endRefreshing()
//            UNoticeBar(config: UNoticeBarConfig(title: "亲,这已经是第一页了")).show(duration: 2)
        } else if index >= detailStatic.chapter_list?.count ?? 0 {
            collectionView.uFoot.endRefreshingWithNoMoreData()
//            UNoticeBar(config: UNoticeBarConfig(title: "亲,已经木有了")).show(duration: 2)
        } else {
            guard let chapterId = detailStatic.chapter_list?[index].chapter_id else { return }
            ApiLoadingProvider.request(UApi.chapter(chapter_id: chapterId), model: ChapterModel.self) { (returnData) in
                
                self.collectionView.uHead.endRefreshing()
                self.collectionView.uFoot.endRefreshing()
                
                guard let chapter = returnData else { return }
                if needClear { self.chapterList.removeAll() }
                if isPreious {
                    self.chapterList.insert(chapter, at: 0)
                } else {
                    self.chapterList.append(chapter)
                }
                self.collectionView.reloadData()
                guard let finished = finished else { return }
                finished(true)
            }
        }
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return chapterList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chapterList[section].image_list?.count ?? 0
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        guard let image = chapterList[indexPath.section].image_list?[indexPath.row] else { return CGSize.zero }
//        let width = YYScreenWidth
//        let height = floor(width / CGFloat(image.width) * CGFloat(image.height))
//        return CGSize(width: width, height: height)
//    }
//
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:U17ReadCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! U17ReadCell
        cell.model = chapterList[indexPath.section].image_list?[indexPath.row]
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
