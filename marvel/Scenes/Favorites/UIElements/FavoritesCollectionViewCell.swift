//
//  FavoritesCollectionViewCell.swift
//  marvel
//
//  Created by Fernando Luiz Goulart on 12/01/21.
//  Copyright © 2021 Fernando Luiz Goulart. All rights reserved.
//

import UIKit

class FavoritesCollectionViewCell: UICollectionViewCell {
    
    // Mark: Outlets
    
    @IBOutlet weak var topMostUIView: UIView!
    @IBOutlet weak var favoriteCharacterImageView: UIImageView!
    @IBOutlet weak var favoriteCharacterNameLabel: UILabel!
    
    // Mark: Variables
    
    var favoriteCharacterId: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
    }
    
    func setupUI() {
        guard let parentView = topMostUIView else { return }
        clipsToBounds = true
        parentView.layer.borderWidth = 1
        parentView.layer.borderColor = UIColor.black.cgColor
        parentView.layer.cornerRadius = 20
        favoriteCharacterNameLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        favoriteCharacterNameLabel.adjustsFontSizeToFitWidth = true
        favoriteCharacterImageView.layer.cornerRadius = 12
    }
    
    
    func update(item: FavoritesPage.DisplayedFavoriteCharacter) {
        self.favoriteCharacterId = item.favoriteCharacterId
        favoriteCharacterNameLabel.text =  item.favoriteCharacterName
        favoriteCharacterImageView.image = item.favoriteCharacterImage
    }
    
}
