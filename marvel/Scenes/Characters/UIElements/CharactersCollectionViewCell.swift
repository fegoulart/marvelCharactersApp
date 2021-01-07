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
    
    var interactor: CharactersBusinessLogic?
    weak var cellDelegate: CharacterCellDelegate?
    var characterId: CharacterId?
    
    
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
        
    }
    
    
    func update(item: CharactersPage.DisplayedCharacter) {
        self.characterId = item.characterId
        characterNameLabel.text =  item.characterName
        characterImageView.download(image: item.characterImageURL)
    }
    
    
    @IBAction func FavoriteUIButtonAction(_ sender: UIButton) {
        self.cellDelegate?.favoriteButtonTapped(cell: self)
    }
    
    
}
