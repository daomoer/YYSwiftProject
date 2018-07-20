//
//  U17OtherBooksController.swift
//  YYSwiftProject
//
//  Created by Domo on 2018/7/20.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit

class U17OtherBooksController: UIViewController {
    
    private var otherWorks: [OtherWorkModel]?
    
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 10
        layout.itemSize = CGSize(width: (YYScreenWidth-40)/3, height:240)
        let collectionView = UICollectionView.init(frame:CGRect(x:0, y:0, width:YYScreenWidth, height:YYScreenHeigth), collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.alwaysBounceVertical = true
        
        collectionView.register(U17OtherWorksCell.self, forCellWithReuseIdentifier: "Cell")
        return collectionView
    }()

    convenience init(otherWorks: [OtherWorkModel]?) {
        self.init()
        self.otherWorks = otherWorks
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.collectionView)

    }
}

extension U17OtherBooksController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return otherWorks?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : U17OtherWorksCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! U17OtherWorksCell
        cell.model = otherWorks?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let comicid:Int = (otherWorks?[indexPath.row].comicId)!
        NotificationCenter.default.post(name: NSNotification.Name("OtherWorksComicid"), object: self, userInfo: ["Comicid":comicid])
        self.navigationController?.popViewController(animated: true)
        
    }
}
