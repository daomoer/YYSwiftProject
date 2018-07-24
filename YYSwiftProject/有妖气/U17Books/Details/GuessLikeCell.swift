//
//  GuessLikeCell.swift
//  YYSwiftProject
//
//  Created by Domo on 2018/7/19.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit

class GuessLikeCell: UITableViewCell {
    lazy var titleLabel : UILabel = {
        let label = UILabel.init(frame: CGRect(x:0, y:0 ,width: YYScreenWidth, height:40))
        label.text = "  猜你喜欢"
        return label
    }()
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.sectionInset = UIEdgeInsetsMake(0, 5, 5, 5)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 8
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        layout.itemSize = CGSize(width: YYScreenWidth/4, height:180)
        let collectionView = UICollectionView.init(frame:CGRect(x:0, y:40, width:YYScreenWidth, height:180), collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.alwaysBounceVertical = true
        collectionView.register(GuessLikeCollectionCell.self, forCellWithReuseIdentifier: "Cell")
        return collectionView
    }()
    
    private var guessLikeModel : GuessLikeModel?

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(self.titleLabel)
        self.addSubview(self.collectionView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var model: GuessLikeModel? {
        didSet {
            guard let model = model else { return }
            self.guessLikeModel = model
            self.collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


extension GuessLikeCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return guessLikeModel?.comics?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let comic = guessLikeModel?.comics![indexPath.row]
        
        let cell:GuessLikeCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! GuessLikeCollectionCell
        cell.imageView.kf.setImage(with: URL(string:(comic?.cover)!))
        cell.nameLabel.text = comic?.name
        return cell
    }
}

class GuessLikeCollectionCell: UICollectionViewCell {
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    lazy var nameLabel : UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.imageView)
//        self.imageView.backgroundColor = UIColor.purple
        self.imageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalToSuperview().offset(-20)
        }
        
        self.addSubview(self.nameLabel)
//        self.nameLabel.text = "山海经"
        self.nameLabel.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.height.equalTo(20)
            make.left.equalTo(5)
            make.right.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
