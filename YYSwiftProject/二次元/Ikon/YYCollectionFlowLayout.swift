//
//  YYCollectionFlowLayout.swift
//  YYSwiftProject
//
//  Created by Domo on 2018/7/12.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import Foundation
import UIKit
@objc public protocol YYCollectionFlowLayoutDelegate: UICollectionViewDelegate {
    
    /// 请求delegate每个item的大小，如果没有实现该方法，那itemSize将是计算出来的边长为columnWidth的正方形
    /// 注意：如果返回的宽度小于计算出来的columnWidth,那实际显示的大小是将itemSize按比例缩放到“宽==columnWidth”的大小
    @objc optional func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: YYCollectionFlowLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    
    @objc optional func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: YYCollectionFlowLayout, numberOfColumnsAt section: Int) -> Int
    
    @objc optional func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: YYCollectionFlowLayout, minimumColumnSpacingForSectionAt section: Int) -> CGFloat
    
    @objc optional func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: YYCollectionFlowLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    
    @objc optional func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: YYCollectionFlowLayout, heightForSectionHeaderInSection section: Int) -> CGFloat
    
    @objc optional func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: YYCollectionFlowLayout, heightForSectionFooterInSection section: Int) -> CGFloat
    
    @objc optional func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: YYCollectionFlowLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    
}

open class YYCollectionFlowLayout: UICollectionViewLayout, YYLayoutHeaderFooterProtocol {
    
    open var columnCount: Int = 2
    
    open var minimumColumnSpacing: CGFloat = 10
    
    open var minimumInteritemSpacing: CGFloat = 10
    
    open var sectionHeaderHeight: CGFloat = 0
    
    open var sectionFooterHeight: CGFloat = 0
    
    open var sectionInset: UIEdgeInsets = UIEdgeInsets.zero
    
    fileprivate weak var delegate: YYCollectionFlowLayoutDelegate? {
        return self.collectionView?.delegate as? YYCollectionFlowLayoutDelegate
    }
    
    fileprivate var contentHeight: CGFloat = 0
    
    /// 这是保存每个section中每个column高度的二维数组，这里用二维数组而不是字典，主要是为了省去字典取值造成的可选绑定
    /// 注意：是column的高度，而不是某个具体cell的高度
    fileprivate var columnHeights = [[CGFloat]]()
    
}


// MARK: - override
extension YYCollectionFlowLayout {
    
    open override func prepare() {
        super.prepare()
        guard let collectionView = self.collectionView else { return }
        let collectionViewWidth = self.collectionViewContentSize.width
        let numberOfSections = collectionView.numberOfSections
        if numberOfSections <= 0 {
            return
        }
        
        self.contentHeight = 0
        self.columnHeights.removeAll()
        self.sectionItemAttributesDict = [Int : [UICollectionViewLayoutAttributes]]()
        self.sectionHeaderAttributesDict = [Int : UICollectionViewLayoutAttributes]()
        self.sectionFooterAttributesDict = [Int : UICollectionViewLayoutAttributes]()
        self.allAttributesArray = [UICollectionViewLayoutAttributes]()
        self.collectionViewHeaderAttributes = nil
        self.collectionViewFooterAttributes = nil
        
        
        for section in 0 ..< numberOfSections {
            
            //初始化columnHeights这个二维数组，全部赋值0
            var columnHeightArray = [CGFloat]()
            let columnCount = self.columnCount(atSection: section)
            for _ in 0 ..< columnCount {
                columnHeightArray.append(0)
            }
            self.columnHeights.append(columnHeightArray)
            
            //初始化sectionItemAttributesDict
            var attributesArray = [UICollectionViewLayoutAttributes]()
            let itemCount = collectionView.numberOfItems(inSection: section)
            for _ in 0 ..< itemCount {
                attributesArray.append(UICollectionViewLayoutAttributes())
            }
            self.sectionItemAttributesDict?[section] = attributesArray
        }
        
        contentHeight = self.collectionViewHeaderHeight
        
        for section in 0 ..< numberOfSections {
            
            let columnSpacing = self.minimumColumnSpacing(atSection: section)
            let itemSpacing = self.minimumInteritemSpacing(atSection: section)
            let inset = self.sectionInset(atSection: section)
            
            //sectionHeader
            let sectionHeaderHeight = self.sectionHeaderHeight(atSection: section)
            if sectionHeaderHeight > 0 {
                let attributes = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, with: IndexPath(item: 0, section: section))
                attributes.frame = CGRect(x: 0, y: contentHeight, width: collectionViewWidth, height: sectionHeaderHeight)
                self.sectionHeaderAttributesDict?[section] = attributes
                contentHeight = attributes.frame.maxY
                self.allAttributesArray?.append(attributes)
            }
            
            let itemCount = collectionView.numberOfItems(inSection: section)
            
            contentHeight += inset.top
            
            //sectionItem
            let columnWidth = self.columnWidth(atSection: section)
            
            for index in 0 ..< itemCount {
                let indexPath = IndexPath(item: index, section: section)
                let columnIndex = self.nextColumnIndexForItem(atIndexPath: indexPath)
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                let offsetX = inset.left + CGFloat(columnIndex) * (columnWidth + columnSpacing)
                var offsetY = self.columnHeights[section][columnIndex]
                if offsetY != 0 { //注意，如果offsetY == 0说明是改列第一个，不用加spacing
                    offsetY += itemSpacing
                }
                offsetY += contentHeight
                
                let size = self.itemSize(atIndexPath: indexPath)
                attributes.frame = CGRect(x: offsetX, y: offsetY, width: size.width, height: size.height)
                self.columnHeights[section][columnIndex] = attributes.frame.maxY - contentHeight
                self.sectionItemAttributesDict?[indexPath.section]?[indexPath.item] = attributes
                self.allAttributesArray?.append(attributes)
            }
            
            if let maxColumnHeight = self.columnHeights[section].max() {
                contentHeight += maxColumnHeight
            }
            
            contentHeight += inset.bottom
            
            //sectionFooter
            let sectionFooterHeight = self.sectionFooterHeight(atSection: section)
            if sectionFooterHeight > 0 {
                let attributes = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, with: IndexPath(item: 0, section: section))
                attributes.frame = CGRect(x: 0, y: contentHeight, width: collectionViewWidth, height: sectionFooterHeight)
                self.sectionFooterAttributesDict?[section] = attributes
                contentHeight = attributes.frame.maxY
                self.allAttributesArray?.append(attributes)
            }
            
        }
        contentHeight += self.collectionViewFooterHeight
        self.allAttributesArray?.append(self.collectionViewHeaderAttributes)
        self.allAttributesArray?.append(self.collectionViewFooterAttributes)
        
        self.clearAttributesIfEmpty()
        
    }
    
    open override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        
        /// 用这几句加上 shouldInvalidateLayout(forBoundsChange newBounds: CGRect)方法配合就可以实现悬浮header，但是貌似意义不大，跟直接add个view上去效果一样
        //        if let collectionView = self.collectionView, let headerAttributes = self.collectionViewHeaderAttributes {
        //            let currentOffset = collectionView.contentOffset.y + collectionView.contentInset.top
        //            headerAttributes.frame.origin.y = currentOffset
        //            headerAttributes.zIndex = 1
        //            if currentOffset < 0 {
        //                headerAttributes.frame.size.height = headerAttributes.frame.height - currentOffset
        //            }
        //        }
        
        
        /// 用这几句加上 shouldInvalidateLayout(forBoundsChange newBounds: CGRect)方法配合就可以实现 跟着滑动放大的header，但是跟上面一样，会导致每次滑动都要重新计算所有的layout，效率很低
        //        if let collectionView = self.collectionView,
        //            let headerAttributes = self.collectionViewHeaderAttributes {
        //            let currentOffset = collectionView.contentOffset.y + collectionView.contentInset.top
        //            if currentOffset < 0 {
        //                headerAttributes.frame.origin.y = currentOffset
        //                headerAttributes.frame.size.height = self.collectionViewHeaderHeight - currentOffset
        //            }
        //
        //        }
        
        
        let resultArray = self.allAttributesArray?.filter { (tempAttributes) -> Bool in
            return tempAttributes.frame.intersects(rect)
        }
        return resultArray
        
    }
    
    
    open override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        if let attributesArray = self.sectionItemAttributesDict?[indexPath.section],
            indexPath.item < attributesArray.count {
            return attributesArray[indexPath.item]
        }
        return nil
    }
    
    
    open override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        if elementKind == UICollectionElementKindSectionHeader {
            return self.sectionHeaderAttributesDict?[indexPath.section]
        } else if elementKind == UICollectionElementKindSectionFooter {
            return self.sectionFooterAttributesDict?[indexPath.section]
        } else if elementKind == YYCollectionElementKindHeader {
            return self.collectionViewHeaderAttributes
        } else if elementKind == YYCollectionElementKindFooter {
            return self.collectionViewFooterAttributes
        } else {
            return nil
        }
        
    }
    
    
    open override var collectionViewContentSize: CGSize {
        
        /// 注意：contentSize是跟contentInset有关的，但是在计算Attributes的时候，不用计算contentInset，貌似系统已经计算过了
        if let collectionView = self.collectionView {
            return CGSize(width: collectionView.bounds.width - collectionView.contentInset.left - collectionView.contentInset.right, height: self.contentHeight)
        }
        return CGSize.zero
    }
    
    
    open override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        if let collectionView = self.collectionView {
            if newBounds.width != collectionView.bounds.width ||
                newBounds.height != collectionView.bounds.height {
                return true
            }
        }
        return false
    }
    
}

// MARK: - PrivateMethod
private extension YYCollectionFlowLayout {
    
    func columnCount(atSection section: Int) -> Int {
        if let collectionView = self.collectionView,
            let count = self.delegate?.collectionView?(collectionView, layout: self, numberOfColumnsAt: section) {
            assert(count > 0, "columnCount must be greater than 0 !!!")
            return count
        } else {
            return self.columnCount
        }
    }
    
    func minimumColumnSpacing(atSection section: Int) -> CGFloat {
        if let collectionView = self.collectionView,
            let spacing = self.delegate?.collectionView?(collectionView, layout: self, minimumColumnSpacingForSectionAt: section) {
            assert(spacing >= 0, "minimumColumnSpacing must be equal or greater than 0 !!!")
            return spacing
        } else {
            return self.minimumColumnSpacing
        }
    }
    
    func minimumInteritemSpacing(atSection section: Int) -> CGFloat {
        if let collectionView = self.collectionView,
            let spacing = self.delegate?.collectionView?(collectionView, layout: self, minimumInteritemSpacingForSectionAt: section) {
            assert(spacing >= 0, "minimumInteritemSpacing must be equal or greater than 0 !!!")
            return spacing
        } else {
            return self.minimumInteritemSpacing
        }
    }
    
    func sectionHeaderHeight(atSection section: Int) -> CGFloat {
        if let collectionView = self.collectionView,
            let height = self.delegate?.collectionView?(collectionView, layout: self, heightForSectionHeaderInSection: section) {
            assert(height >= 0, "sectionHeaderHeight must be equal or greater than 0 !!!")
            return height
        } else {
            return self.sectionHeaderHeight
        }
    }
    
    func sectionFooterHeight(atSection section: Int) -> CGFloat {
        if let collectionView = self.collectionView,
            let height = self.delegate?.collectionView?(collectionView, layout: self, heightForSectionFooterInSection: section) {
            assert(height >= 0, "sectionFooterHeight must be equal or greater than 0 !!!")
            return height
        } else {
            return self.sectionFooterHeight
        }
    }
    
    func sectionInset(atSection section: Int) -> UIEdgeInsets {
        if let collectionView = self.collectionView,
            let sectionInset = self.delegate?.collectionView?(collectionView, layout: self, insetForSectionAt: section) {
            return sectionInset
        } else {
            return self.sectionInset
        }
    }
    
    
    func nextColumnIndexForItem(atIndexPath indexPath: IndexPath) -> Int {
        //这里是直接按 最短优先 来排列，其他的方式感觉意义不大
        var index: Int = 0
        var shortestHeight = CGFloat.greatestFiniteMagnitude
        for (location, tempHeight) in self.columnHeights[indexPath.section].enumerated() {
            if shortestHeight > tempHeight {
                shortestHeight = tempHeight
                index = location
            }
        }
        return index
        
    }
    
    
    func scaledSize(forOriginalSize size: CGSize, limitWidth: CGFloat) -> CGSize {
        if size.width <= 0.01 || size.height <= 0.01 || limitWidth <= 0.01 {
            return CGSize.zero
        }
        let width = floor(limitWidth)
        let height = ceil(width * size.height / size.width)
        return CGSize(width: width, height: height)
    }
    
}

// MARK: - PublicMethod
public extension YYCollectionFlowLayout {
    
    public func columnWidth(atSection section: Int) -> CGFloat {
        let count = self.columnCount(atSection: section)
        let sectionInset = self.sectionInset(atSection: section)
        let spacing = self.minimumColumnSpacing(atSection: section)
        let width = self.collectionViewContentSize.width - sectionInset.left - sectionInset.right
        if count > 1 {
            return floor((width - CGFloat(count - 1) * spacing) / CGFloat(count))
        } else {
            return width
        }
    }
    
    public func itemSize(atIndexPath indexPath: IndexPath) -> CGSize {
        if let collectionView = self.collectionView,
            let itemSize = self.delegate?.collectionView?(collectionView, layout: self, sizeForItemAt: indexPath) {
            let columnWidth = self.columnWidth(atSection: indexPath.section)
            if itemSize.width == columnWidth {
                return itemSize
            } else {
                return self.scaledSize(forOriginalSize: itemSize, limitWidth: columnWidth)
            }
        } else {
            let columnWidth = self.columnWidth(atSection: indexPath.section)
            return CGSize(width: columnWidth, height: columnWidth)
        }
    }
}



