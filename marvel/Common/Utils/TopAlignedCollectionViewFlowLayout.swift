//
//  TopAlignedCollectionViewFlowLayout.swift
//  marvel
//
//  Created by Fernando Luiz Goulart on 01/01/21.
//  Copyright © 2021 Fernando Luiz Goulart. All rights reserved.
//

import Foundation
import UIKit

//class TopAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {
//    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
//        guard let attributes = super.layoutAttributesForElements(in: rect) else {
//            return nil
//        }
//        var baseline: CGFloat = -2
//        var sameLineAttributes = [UICollectionViewLayoutAttributes]()
//        for attribute in attributes where attribute.representedElementCategory == .cell {
//            let centerY = attribute.center.y
//            if abs(centerY - baseline) > 1 {
//                baseline = centerY
//                alignToTop(sameLineAttributes: sameLineAttributes)
//                sameLineAttributes.removeAll()
//            }
//            sameLineAttributes.append(attribute)
//        }
//        alignToTop(sameLineAttributes: sameLineAttributes) // align one more time for the last line
//        return attributes
//    }
//
//    private func alignToTop(sameLineAttributes: [UICollectionViewLayoutAttributes]) {
//        if sameLineAttributes.count < 1 { return }
//
//        let tallest2 = sameLineAttributes.max { $0.frame.size.height < $1.frame.size.height }
//        guard let tallest = tallest2 else { return }
//            for obj in sameLineAttributes {
//                obj.frame = obj.frame.offsetBy(dx: 0, dy: tallest.frame.origin.y - obj.frame.origin.y)
//            }
//    }
//}

class TwoColumnsViewFlowLayout: UICollectionViewFlowLayout {

    let numberOfColumns = 2
    let columnSpacing: CGFloat = 8
    let rowSpacing: CGFloat = 16
    var estimatedColumnSpan = 1
    var estimatedCellHeight: CGFloat = 150
    private var collectionViewContentHeight: CGFloat = 0
    private var attributes: [IndexPath: UICollectionViewLayoutAttributes] = [:]
        
    override func prepare() {
        super.prepare()
        guard let collectionView = collectionView else { return }
        
        
    
        
        let availableWidth = UIEdgeInsetsInsetRect(collectionView.bounds, collectionView.layoutMargins).width
        let columns = 2
        let cellWidth = (availableWidth / CGFloat(columns)).rounded(.down)
        self.itemSize = CGSize(width: cellWidth, height: cellWidth)
        //self.itemSize = CGSize(width: CGFloat(150), height: CGFloat(150))
        
        self.sectionInset = UIEdgeInsets(top: self.minimumInteritemSpacing, left: 0.0, bottom: 0.0, right: 0.0)
        self.sectionInsetReference = .fromSafeArea

        
    }
    
    
}

