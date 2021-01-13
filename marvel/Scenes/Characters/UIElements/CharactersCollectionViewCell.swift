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
    
    @IBOutlet weak var topMostUIView: UIView!
    @IBOutlet weak var favoriteButton: UIButton!
    
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterImageView: UIImageView!
    
    weak var cellDelegate: CharacterCellDelegate?
    var characterId: CharacterId?
    var isFavorite: Bool = false
    var indexPath: Int?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
    }
    
    func setupUI() {
        isSkeletonable = true
        clipsToBounds = true
        topMostUIView.layer.borderWidth = 1
        topMostUIView.layer.borderColor = UIColor.black.cgColor
        topMostUIView.layer.cornerRadius = 20
        characterNameLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        characterNameLabel.adjustsFontSizeToFitWidth = true
        characterImageView.layer.cornerRadius = 12
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        topMostUIView.addGestureRecognizer(tap)
        
    }
    
    
    func update(item: CharactersPage.DisplayedCharacter, indexPath: Int) {
        self.characterId = item.characterId
        characterNameLabel.text =  item.characterName
        characterImageView.download(image: item.characterImageURL)
        if (item.isFavorite) {
            favoriteButton.isSelected = true
            self.isFavorite = true
        } else {
            favoriteButton.isSelected = false
            self.isFavorite = false
        }
        self.indexPath = indexPath
    }
    
    
    @IBAction func FavoriteUIButtonAction(_ sender: UIButton) {
        self.cellDelegate?.favoriteButtonTapped(cell: self)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        self.cellDelegate?.cellSelected(cell: self)
    }
    
    
}
