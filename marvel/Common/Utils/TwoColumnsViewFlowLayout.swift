//
//  TopAlignedCollectionViewFlowLayout.swift
//  marvel
//
//  Created by Fernando Luiz Goulart on 01/01/21.
//  Copyright © 2021 Fernando Luiz Goulart. All rights reserved.
//

import Foundation
import UIKit

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
        self.sectionInset = UIEdgeInsets(top: self.minimumInteritemSpacing, left: 0.0, bottom: 0.0, right: 0.0)
        self.sectionInsetReference = .fromSafeArea

        
    }
    
    
}

