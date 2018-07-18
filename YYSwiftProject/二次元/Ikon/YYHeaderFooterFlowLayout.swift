//
//  YYHeaderFooterFlowLayout.swift
//  YYSwiftProject
//
//  Created by Domo on 2018/7/13.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit

public enum YYLayoutHorizontalAlignment {
    
    case left // Visually left aligned
    
    case center // Visually centered
    
    case right // Visually right aligned
    
    case justified // Fully-justified, it is different from UICollectionViewFlowLayout default behavior, which will layout the cell in last line one by one with minimumInteritemSpacing if there is not enough cell.
    
    case none  // use UICollectionViewFlowLayout's alignment
}

public enum YYLayoutVerticalAlignment {
    
    case top // Visually top aligned
    
    case center // Visually centered
    
    case bottom // Visually bottom aligned
    
    case justified // Fully-justified, it is different from UICollectionViewFlowLayout default behavior, which will layout the cell in last line one by one with minimumInteritemSpacing if there is not enough cell.
    
    case none  // use UICollectionViewFlowLayout's alignment
}

open class YYHeaderFooterFlowLayout: UICollectionViewFlowLayout, YYLayoutHeaderFooterProtocol {
    
    /// Notice: horiziontalAlignment does nothing when scrollDirection == .horizontal
    open var horiziontalAlignment: YYLayoutHorizontalAlignment = .none
    
    /// Notice: verticalAlignment does nothing when scrollDirection == .vertical
    open var verticalAlignment: YYLayoutVerticalAlignment = .none
}

extension YYHeaderFooterFlowLayout {
    open override func prepare() {
        super.prepare()
        
        guard let collectionView = self.collectionView else { return }
        let numberOfSections = collectionView.numberOfSections
        if numberOfSections <= 0 {
            return
        }
        
        self.sectionItemAttributesDict = [Int : [UICollectionViewLayoutAttributes]]()
        self.sectionHeaderAttributesDict = [Int : UICollectionViewLayoutAttributes]()
        self.sectionFooterAttributesDict = [Int : UICollectionViewLayoutAttributes]()
        self.allAttributesArray = [UICollectionViewLayoutAttributes]()
        
        
        for section in 0 ..< numberOfSections {
            var attributesArray = [UICollectionViewLayoutAttributes]()
            for index in 0 ..< collectionView.numberOfItems(inSection: section) {
                let indexPath = IndexPath(item: index, section: section)
                var itemAttributes: UICollectionViewLayoutAttributes?
                itemAttributes = super.layoutAttributesForItem(at: indexPath)?.copy() as? UICollectionViewLayoutAttributes
                itemAttributes = self.updateAttributesForHeaderAndFooter(attributes: itemAttributes)
                attributesArray.append(itemAttributes)
            }
            self.sectionItemAttributesDict?[section] = attributesArray.isEmpty ? nil : attributesArray
            self.allAttributesArray?.append(contentsOf: attributesArray)
            
            var headerAttributes = super.layoutAttributesForSupplementaryView(ofKind: UICollectionElementKindSectionHeader, at: IndexPath(item: 0, section: section))?.copy() as? UICollectionViewLayoutAttributes
            headerAttributes = self.updateAttributesForHeaderAndFooter(attributes: headerAttributes)
            self.sectionHeaderAttributesDict?[section] = headerAttributes
            
            var footerAttributes = super.layoutAttributesForSupplementaryView(ofKind: UICollectionElementKindSectionFooter, at: IndexPath(item: 0, section: section))?.copy() as? UICollectionViewLayoutAttributes
            footerAttributes = self.updateAttributesForHeaderAndFooter(attributes: footerAttributes)
            self.sectionFooterAttributesDict?[section] = footerAttributes
        }
        
        self.allAttributesArray = self.updateAttributesForAlignment(attributesArray: self.allAttributesArray)
        self.allAttributesArray?.append(contentsOf: self.sectionHeaderAttributesDict?.values)
        self.allAttributesArray?.append(contentsOf: self.sectionFooterAttributesDict?.values)
        self.allAttributesArray?.append(self.collectionViewHeaderAttributes)
        self.allAttributesArray?.append(self.collectionViewFooterAttributes)
        
        self.clearAttributesIfEmpty()
    }
    
    
    open override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        //注意，这里直接调用super.layoutAttributesForElements(in rect: CGRect)在修改里面UICollectionViewLayoutAttributes的方法是不行的，系统应该是有做缓存，当所有UICollectionViewLayoutAttributes存在以后，系统就不会再调用此方法。这里因为多了header，所有item的位置都会相应下移，可能会使缓存的与返回的item有重复，导致位置错误
        
        return self.allAttributesArray?.filter({ (attributes) -> Bool in
            return attributes.frame.intersects(rect)
        })
    }
    
    
    open override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return self.sectionItemAttributesDict?[indexPath.section]?[indexPath.item]
    }
    
    
    open override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        if elementKind == YYCollectionElementKindHeader {
            return self.collectionViewHeaderAttributes
        } else if elementKind == YYCollectionElementKindFooter {
            return self.collectionViewFooterAttributes
        } else if elementKind == UICollectionElementKindSectionHeader {
            return self.sectionHeaderAttributesDict?[indexPath.section]
        } else if elementKind == UICollectionElementKindSectionFooter {
            return self.sectionFooterAttributesDict?[indexPath.section]
        } else {
            return super.layoutAttributesForSupplementaryView(ofKind: elementKind, at: indexPath)
        }
    }
    
    
    /// 注意：一定要用super.collectionViewContentSize返回的宽度，系统貌似根据contentInset做了优化计算
    open override var collectionViewContentSize: CGSize {
        return updateContentSizeForHeaderAndFooter(contentSize: super.collectionViewContentSize)
    }
    
    
    open override func shouldInvalidateLayout (forBoundsChange newBounds: CGRect) -> Bool {
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
private extension YYHeaderFooterFlowLayout {
    
    func groupedArray(attributesArray: [UICollectionViewLayoutAttributes]) -> [[UICollectionViewLayoutAttributes]] {
        var groupArray = [[UICollectionViewLayoutAttributes]]()
        var currentSection: Int = -1
        var currentValue: CGFloat = CGFloat.greatestFiniteMagnitude
        for attributes in attributesArray {
            if self.scrollDirection == .vertical {
                if attributes.center.y == currentValue {
                    groupArray[currentSection].append(attributes)
                } else {
                    currentSection += 1
                    groupArray.append([UICollectionViewLayoutAttributes]())
                    groupArray[currentSection].append(attributes)
                    currentValue = attributes.center.y
                }
            } else {
                if attributes.center.x == currentValue {
                    groupArray[currentSection].append(attributes)
                } else {
                    currentSection += 1
                    groupArray.append([UICollectionViewLayoutAttributes]())
                    groupArray[currentSection].append(attributes)
                    currentValue = attributes.center.x
                }
            }
            
            
        }
        return groupArray
    }
    
    func updateAttributesForAlignment(attributesArray: [UICollectionViewLayoutAttributes]?) -> [UICollectionViewLayoutAttributes]? {
        if self.scrollDirection == .vertical && self.horiziontalAlignment == .none {
            return attributesArray
        }
        if self.scrollDirection == .horizontal && self.verticalAlignment == .none {
            return attributesArray
        }
        
        guard let attributesArray = attributesArray else { return nil }
        let groupArray = self.groupedArray(attributesArray: attributesArray)
        var resultArray = [UICollectionViewLayoutAttributes]()
        for lineArray in groupArray {
            
            if self.scrollDirection == .vertical {
                if self.horiziontalAlignment == .left {
                    if var currentItem = lineArray.first {
                        if currentItem.representedElementKind != nil {
                            resultArray.append(currentItem)
                            continue
                        }
                        
                        currentItem.frame.origin.x = insetForSection(at: currentItem.indexPath.section).left
                        resultArray.append(currentItem)
                        for i in 1 ..< lineArray.count {
                            let attributes = lineArray[i]
                            attributes.frame.origin.x = currentItem.frame.maxX + minimumInteritemSpacingForSection(at: currentItem.indexPath.section)
                            resultArray.append(attributes)
                            currentItem = attributes
                        }
                    }
                }
                else if self.horiziontalAlignment == .right {
                    if var currentItem = lineArray.last {
                        if currentItem.representedElementKind != nil {
                            resultArray.append(currentItem)
                            continue
                        }
                        let rightSpacing = insetForSection(at: currentItem.indexPath.section).right
                        
                        currentItem.frame.origin.x = self.collectionViewContentSize.width - rightSpacing - currentItem.frame.width
                        resultArray.append(currentItem)
                        
                        for i in 1 ..< lineArray.count {
                            let attributes = lineArray[lineArray.count - 1 - i]
                            attributes.frame.origin.x = currentItem.frame.minX - minimumInteritemSpacingForSection(at: currentItem.indexPath.section) - attributes.frame.width
                            resultArray.append(attributes)
                            currentItem = attributes
                        }
                    }
                }
                else if self.horiziontalAlignment == .center {
                    
                    if var currentItem = lineArray.first {
                        if currentItem.representedElementKind != nil {
                            resultArray.append(currentItem)
                            continue
                        }
                        let inset = insetForSection(at: currentItem.indexPath.section)
                        let totalItemWidth = lineArray.reduce(0, { (result, attributes) in
                            return result + attributes.frame.width
                        })
                        let itemSpacing = minimumInteritemSpacingForSection(at: currentItem.indexPath.section)
                        let sapcing = (self.collectionViewContentSize.width - inset.left - inset.right - totalItemWidth - (itemSpacing * CGFloat(lineArray.count - 1))) / 2
                        
                        currentItem.frame.origin.x = inset.left + sapcing
                        resultArray.append(currentItem)
                        for i in 1 ..< lineArray.count {
                            let attributes = lineArray[i]
                            attributes.frame.origin.x = currentItem.frame.maxX + itemSpacing
                            resultArray.append(attributes)
                            currentItem = attributes
                        }
                    }
                }
                else if self.horiziontalAlignment == .justified {
                    
                    if var currentItem = lineArray.first {
                        if currentItem.representedElementKind != nil {
                            resultArray.append(currentItem)
                            continue
                        }
                        let inset = insetForSection(at: currentItem.indexPath.section)
                        let totalItemWidth = lineArray.reduce(0, { (result, attributes) in
                            return result + attributes.frame.width
                        })
                        
                        currentItem.frame.origin.x = inset.left
                        resultArray.append(currentItem)
                        if lineArray.count == 1 {
                            continue
                        }
                        
                        let sapcing = (self.collectionViewContentSize.width - inset.left - inset.right - totalItemWidth) / CGFloat(lineArray.count - 1)
                        
                        for i in 1 ..< lineArray.count {
                            let attributes = lineArray[i]
                            attributes.frame.origin.x = currentItem.frame.maxX + sapcing
                            resultArray.append(attributes)
                            currentItem = attributes
                        }
                    }
                }
            }
            else {
                if self.verticalAlignment == .top {
                    if var currentItem = lineArray.first {
                        if currentItem.representedElementKind != nil {
                            resultArray.append(currentItem)
                            continue
                        }
                        
                        currentItem.frame.origin.y = insetForSection(at: currentItem.indexPath.section).top
                        resultArray.append(currentItem)
                        for i in 1 ..< lineArray.count {
                            let attributes = lineArray[i]
                            attributes.frame.origin.y = currentItem.frame.maxY + minimumLineSpacingForSection(at: currentItem.indexPath.section)
                            resultArray.append(attributes)
                            currentItem = attributes
                        }
                    }
                }
                else if self.verticalAlignment == .bottom {
                    if var currentItem = lineArray.last {
                        if currentItem.representedElementKind != nil {
                            resultArray.append(currentItem)
                            continue
                        }
                        let bottomSpacing = insetForSection(at: currentItem.indexPath.section).bottom
                        
                        currentItem.frame.origin.y = self.collectionViewContentSize.height - bottomSpacing - currentItem.frame.height
                        resultArray.append(currentItem)
                        
                        for i in 1 ..< lineArray.count {
                            let attributes = lineArray[lineArray.count - 1 - i]
                            attributes.frame.origin.y = currentItem.frame.minY - minimumLineSpacingForSection(at: currentItem.indexPath.section) - attributes.frame.height
                            resultArray.append(attributes)
                            currentItem = attributes
                        }
                    }
                }
                else if self.verticalAlignment == .center {
                    
                    if var currentItem = lineArray.first {
                        if currentItem.representedElementKind != nil {
                            resultArray.append(currentItem)
                            continue
                        }
                        let inset = insetForSection(at: currentItem.indexPath.section)
                        let totalItemHeight = lineArray.reduce(0, { (result, attributes) in
                            return result + attributes.frame.height
                        })
                        let lineSpacing = minimumLineSpacingForSection(at: currentItem.indexPath.section)
                        let sapcing = (self.collectionViewContentSize.height - inset.top - inset.bottom - totalItemHeight - (lineSpacing * CGFloat(lineArray.count - 1))) / 2
                        
                        currentItem.frame.origin.y = inset.top + sapcing
                        resultArray.append(currentItem)
                        for i in 1 ..< lineArray.count {
                            let attributes = lineArray[i]
                            attributes.frame.origin.y = currentItem.frame.maxY + lineSpacing
                            resultArray.append(attributes)
                            currentItem = attributes
                        }
                    }
                }
                else if self.verticalAlignment == .justified {
                    
                    if var currentItem = lineArray.first {
                        if currentItem.representedElementKind != nil {
                            resultArray.append(currentItem)
                            continue
                        }
                        let inset = insetForSection(at: currentItem.indexPath.section)
                        let totalItemHeight = lineArray.reduce(0, { (result, attributes) in
                            return result + attributes.frame.height
                        })
                        
                        currentItem.frame.origin.y = inset.top
                        resultArray.append(currentItem)
                        if lineArray.count == 1 {
                            continue
                        }
                        
                        let sapcing = (self.collectionViewContentSize.height - inset.top - inset.bottom - totalItemHeight) / CGFloat(lineArray.count - 1)
                        
                        for i in 1 ..< lineArray.count {
                            let attributes = lineArray[i]
                            attributes.frame.origin.y = currentItem.frame.maxY + sapcing
                            resultArray.append(attributes)
                            currentItem = attributes
                        }
                    }
                }
            }
            
        }
        return resultArray
        
    }
    
    
}

