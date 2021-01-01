//
//  CharactersCollectionViewCell.swift
//  marvel
//
//  Created by Fernando Luiz Goulart on 01/01/21.
//  Copyright © 2021 Fernando Luiz Goulart. All rights reserved.
//

import UIKit
import SkeletonView

class CharactersCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        isSkeletonable = true
        clipsToBounds = true
    }
    
    func update(item: CharactersPage.DisplayedCharacter) {
        characterNameLabel.text =  item.characterName
        characterImageView.download(image: item.characterImageURL)
    }
    
    /*
     func getSize(_ width: CGFloat) -> CGSize {
         widthConstraint.constant = width
         guard let title = lblTitle.text else {
              return CGSize(width: width, height: width)
         }
         let titleWidth = width - 10
         let totalHeight = width + title.height(constraintedWidth: titleWidth, font: lblTitle.font) + 10
         return CGSize(width: width, height: totalHeight)
     }
     */
    
}
