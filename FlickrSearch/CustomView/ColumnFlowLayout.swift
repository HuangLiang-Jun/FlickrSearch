//
//  ColumnFlowLayout.swift
//  FlickrSearch
//
//  Created by 黃亮鈞 on 2019/3/7.
//  Copyright © 2019 黃亮鈞. All rights reserved.
//

import Foundation
import UIKit


//Resize CollectionView Cell when setting cells per row
class ColumnFlowLayout: UICollectionViewFlowLayout {
    
    
    private let cellsPerRow: Int
    override var itemSize: CGSize {
        get {
            
            guard let collectionView = collectionView else { return super.itemSize }
            let marginsAndInsets = sectionInset.left + sectionInset.right + minimumInteritemSpacing * CGFloat(cellsPerRow - 1)
            let itemWidth = ((collectionView.bounds.size.width - marginsAndInsets) / CGFloat(cellsPerRow)).rounded(.down)
            return CGSize(width: itemWidth, height: itemWidth + 40)
        }
        set {
            super.itemSize = newValue
        }
    }
    
    /// 設定每行item的數量，並設定cell合適的尺寸
    ///
    /// - Parameters:
    ///   - cellsPerRow: 每行item的數量
    ///   - minimumInteritemSpacing: 水平item間距
    ///   - minimumLineSpacing: 垂直item間距
    ///   - sectionInset: Section內容邊距
    init(cellsPerRow: Int, minimumInteritemSpacing: CGFloat = 0, minimumLineSpacing: CGFloat = 0, sectionInset: UIEdgeInsets = .zero) {
        self.cellsPerRow = cellsPerRow
        super.init()
        
        self.minimumInteritemSpacing = minimumInteritemSpacing
        self.minimumLineSpacing = minimumLineSpacing
        self.sectionInset = sectionInset
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func invalidationContext(forBoundsChange newBounds: CGRect) -> UICollectionViewLayoutInvalidationContext {
        let context = super.invalidationContext(forBoundsChange: newBounds) as! UICollectionViewFlowLayoutInvalidationContext
        context.invalidateFlowLayoutDelegateMetrics = newBounds != collectionView?.bounds
        return context
    }
    
    
}
