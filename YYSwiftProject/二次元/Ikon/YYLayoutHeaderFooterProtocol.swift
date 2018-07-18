
//
//  YYLayoutHeaderFooterProtocol.swift
//  YYSwiftProject
//
//  Created by Domo on 2018/7/13.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import Foundation
import UIKit

public let YYCollectionElementKindHeader: String = "YYCollectionElementKindHeader"

public let YYCollectionElementKindFooter: String = "YYCollectionElementKindFooter"


/// 此协议声明成只有类可以遵守，因为本来就是给UICollectionViewLayout用的
/// 里面有修改self属性的方法，如果结构体等值类型也可以遵守该协议的话，会复杂很多
/// 具体原因见：https://www.bignerdranch.com/blog/protocol-oriented-problems-and-the-immutable-self-error/
public protocol YYLayoutHeaderFooterProtocol: class {
    
    var collectionViewHeaderHeight: CGFloat { get set }
    
    var collectionViewFooterHeight: CGFloat { get set }
    
    /// 如果collectionViewHeaderHeight > 0 则有默认值，否则为nil
    /// 可以通过赋值nil来重新生成默认值
    var collectionViewHeaderAttributes: UICollectionViewLayoutAttributes? { get set }
    
    /// 如果collectionViewFooterHeight > 0 则有默认值，否则为nil
    /// 可以通过赋值nil来重新生成默认值
    var collectionViewFooterAttributes: UICollectionViewLayoutAttributes? { get set }
    
}



private var kYYCollectionViewHeaderHeightKey: String = "kYYCollectionViewHeaderHeightKey"
private var kYYCollectionViewFooterHeightKey: String = "kYYCollectionViewFooterHeightKey"
private var kYYCollectionViewHeaderAttributesKey: String = "kYYCollectionViewHeaderAttributesKey"
private var kYYCollectionViewFooterAttributesKey: String = "kYYCollectionViewFooterAttributesKey"

public extension YYLayoutHeaderFooterProtocol where Self: UICollectionViewLayout {
    
    var collectionViewHeaderHeight: CGFloat {
        set {
            assert(newValue >= 0, "collectionViewHeaderHeight must be equal or greater than 0 !!!")
            let value = NSNumber(value: Float(newValue))
            objc_setAssociatedObject(self, &kYYCollectionViewHeaderHeightKey, value, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            if let value = objc_getAssociatedObject(self, &kYYCollectionViewHeaderHeightKey) as? NSNumber {
                return CGFloat(value.floatValue)
            }
            return 0
        }
    }
    
    var collectionViewFooterHeight: CGFloat {
        set {
            assert(newValue >= 0, "collectionViewFooterHeight must be equal or greater than 0 !!!")
            let value = NSNumber(value: Float(newValue))
            objc_setAssociatedObject(self, &kYYCollectionViewFooterHeightKey, value, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            if let value = objc_getAssociatedObject(self, &kYYCollectionViewFooterHeightKey) as? NSNumber {
                return CGFloat(value.floatValue)
            }
            return 0
        }
    }
    
    var collectionViewHeaderAttributes: UICollectionViewLayoutAttributes? {
        set {
            objc_setAssociatedObject(self, &kYYCollectionViewHeaderAttributesKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            if let attributes = objc_getAssociatedObject(self, &kYYCollectionViewHeaderAttributesKey) as? UICollectionViewLayoutAttributes {
                return attributes
            } else {
                if self.collectionViewHeaderHeight > 0 {
                    let attributes = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: YYCollectionElementKindHeader, with: IndexPath())
                    attributes.frame = CGRect(x: 0,
                                              y: 0,
                                              width: self.collectionViewContentSize.width,
                                              height: self.collectionViewHeaderHeight)
                    if let layout = self as? UICollectionViewFlowLayout, layout.scrollDirection == .horizontal {
                        attributes.frame = CGRect(x: 0,
                                                  y: 0,
                                                  width: self.collectionViewHeaderHeight,
                                                  height: self.collectionViewContentSize.height)
                    }
                    self.collectionViewHeaderAttributes = attributes
                    return attributes
                }
                return nil
            }
        }
    }
    
    var collectionViewFooterAttributes: UICollectionViewLayoutAttributes? {
        set {
            objc_setAssociatedObject(self, &kYYCollectionViewFooterAttributesKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            if let attributes = objc_getAssociatedObject(self, &kYYCollectionViewFooterAttributesKey) as? UICollectionViewLayoutAttributes {
                return attributes
            } else {
                if self.collectionViewFooterHeight > 0 {
                    let attributes = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: YYCollectionElementKindFooter, with: IndexPath())
                    attributes.frame = CGRect(x: 0,
                                              y: self.collectionViewContentSize.height - self.collectionViewFooterHeight,
                                              width: self.collectionViewContentSize.width,
                                              height: self.collectionViewFooterHeight)
                    if let layout = self as? UICollectionViewFlowLayout, layout.scrollDirection == .horizontal {
                        attributes.frame = CGRect(x: self.collectionViewContentSize.width - self.collectionViewFooterHeight,
                                                  y: 0,
                                                  width: self.collectionViewFooterHeight,
                                                  height: self.collectionViewContentSize.height)
                    }
                    self.collectionViewFooterAttributes = attributes
                    return attributes
                }
                return nil
            }
        }
    }
    
    
    
    func updateAttributesForHeaderAndFooter(attributes: UICollectionViewLayoutAttributes?) -> UICollectionViewLayoutAttributes? {
        if let result = attributes?.copy() as? UICollectionViewLayoutAttributes {
            
            if let layout = self as? UICollectionViewFlowLayout, layout.scrollDirection == .horizontal {
                result.frame.origin.x += self.collectionViewHeaderHeight
            } else {
                result.frame.origin.y += self.collectionViewHeaderHeight
            }
            
            return result
        }
        return nil
        
    }
    
    func updateContentSizeForHeaderAndFooter(contentSize: CGSize) -> CGSize {
        var size = contentSize
        if let layout = self as? UICollectionViewFlowLayout, layout.scrollDirection == .horizontal {
            size.width += self.collectionViewHeaderHeight + self.collectionViewFooterHeight
        } else {
            size.height += self.collectionViewHeaderHeight + self.collectionViewFooterHeight
        }
        return size
    }
    
    
    
    
}



private var kYYCollectionViewSectionItemAttributesDictKey = "kYYCollectionViewSectionItemAttributesDictKey"
private var kYYCollectionViewSectionHeaderAttributesDictKey = "kYYCollectionViewSectionHeaderAttributesDictKey"
private var kYYCollectionViewSectionFooterAttributesDictKey = "kYYCollectionViewSectionFooterAttributesDictKey"
private var kYYCollectionViewAllAttributesArrayKey = "kYYCollectionViewAllAttributesArrayKey"

public extension UICollectionViewLayout {
    
    /// 保存每个section中每个item的Attributes的字典，key是section
    var sectionItemAttributesDict: [Int : [UICollectionViewLayoutAttributes]]? {
        set {
            objc_setAssociatedObject(self, &kYYCollectionViewSectionItemAttributesDictKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &kYYCollectionViewSectionItemAttributesDictKey) as? [Int : [UICollectionViewLayoutAttributes]]
        }
    }
    
    
    // 保存sectionHeader的attributes的字典，key是section
    var sectionHeaderAttributesDict: [Int : UICollectionViewLayoutAttributes]? {
        set {
            objc_setAssociatedObject(self, &kYYCollectionViewSectionHeaderAttributesDictKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &kYYCollectionViewSectionHeaderAttributesDictKey) as? [Int : UICollectionViewLayoutAttributes]
        }
    }
    
    /// 保存sectionFooter的attributes的字典，key是section
    var sectionFooterAttributesDict: [Int : UICollectionViewLayoutAttributes]? {
        set {
            objc_setAssociatedObject(self, &kYYCollectionViewSectionFooterAttributesDictKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &kYYCollectionViewSectionFooterAttributesDictKey) as? [Int : UICollectionViewLayoutAttributes]
        }
    }
    
    /// 所有item的attributes的数组，包括cell和SectionHeader，SectionFooter, collectionViewHeader, collectionViewFooter
    var allAttributesArray: [UICollectionViewLayoutAttributes]? {
        set {
            objc_setAssociatedObject(self, &kYYCollectionViewAllAttributesArrayKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &kYYCollectionViewAllAttributesArrayKey) as? [UICollectionViewLayoutAttributes]
        }
    }
    
    func clearAttributesIfEmpty() {
        if let dict = self.sectionItemAttributesDict, dict.isEmpty {
            self.sectionItemAttributesDict = nil
        }
        if let dict = self.sectionHeaderAttributesDict, dict.isEmpty {
            self.sectionHeaderAttributesDict = nil
        }
        if let dict = self.sectionFooterAttributesDict, dict.isEmpty {
            self.sectionFooterAttributesDict = nil
        }
        if let dict = self.allAttributesArray, dict.isEmpty {
            self.allAttributesArray = nil
        }
    }
    
}



// MARK: - Tool
extension Array {
    public mutating func append(_ newElement: Element?) {
        if let newElement = newElement {
            self.append(newElement)
        }
    }
    
    public mutating func append<S>(contentsOf newElements: S?) where S : Sequence, S.Iterator.Element == Element {
        if let newElements = newElements {
            self.append(contentsOf: newElements)
        }
    }
    
    public mutating func insert(_ newElement: Element?, at i: Int) {
        if let newElement = newElement {
            self.insert(newElement, at: i)
        }
    }
}


// MARK: - Tool
public extension UICollectionViewFlowLayout {
    
    fileprivate var delegate: UICollectionViewDelegateFlowLayout? {
        return self.collectionView?.delegate as? UICollectionViewDelegateFlowLayout
    }
    
    func sizeForItem(atIndexPath indexPath: IndexPath) -> CGSize {
        if let collectionView = self.collectionView {
            return self.delegate?.collectionView?(collectionView, layout: self, sizeForItemAt: indexPath) ?? self.itemSize
        }
        return self.itemSize
    }
    
    func insetForSection(at section: Int) -> UIEdgeInsets {
        if let collectionView = self.collectionView {
            return self.delegate?.collectionView?(collectionView, layout: self, insetForSectionAt: section) ?? self.sectionInset
        }
        return self.sectionInset
    }
    
    func minimumLineSpacingForSection(at section: Int) -> CGFloat {
        if let collectionView = self.collectionView {
            return self.delegate?.collectionView?(collectionView, layout: self, minimumLineSpacingForSectionAt: section) ?? self.minimumLineSpacing
        }
        return self.minimumLineSpacing
    }
    
    func minimumInteritemSpacingForSection(at section: Int) -> CGFloat {
        if let collectionView = self.collectionView {
            return self.delegate?.collectionView?(collectionView, layout: self, minimumInteritemSpacingForSectionAt: section) ?? self.minimumInteritemSpacing
        }
        return self.minimumInteritemSpacing
    }
    
    func referenceSizeForHeaderInSection(section: Int) -> CGSize {
        if let collectionView = self.collectionView {
            return self.delegate?.collectionView?(collectionView, layout: self, referenceSizeForHeaderInSection: section) ?? self.headerReferenceSize
        }
        return self.headerReferenceSize
    }
    
    func referenceSizeForFooterInSection(section: Int) -> CGSize {
        if let collectionView = self.collectionView {
            return self.delegate?.collectionView?(collectionView, layout: self, referenceSizeForFooterInSection: section) ?? self.footerReferenceSize
        }
        return self.footerReferenceSize
    }
    
}
