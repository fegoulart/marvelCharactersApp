//
//  SingleCharacterCollectionViewCell.swift
//  marvel
//
//  Created by Fernando Luiz Goulart on 12/01/21.
//  Copyright © 2021 Fernando Luiz Goulart. All rights reserved.
//

import UIKit

class SingleCharacterCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var topMostUIView: SingleCharacterCollectionViewCell!
    @IBOutlet weak var productionImage: UIImageView!
    @IBOutlet weak var productionName: UILabel!
    
    // Mark: Variables
    
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
        productionName.lineBreakMode = NSLineBreakMode.byWordWrapping
        productionName.adjustsFontSizeToFitWidth = true
        productionImage.layer.cornerRadius = 12
    }
    
    func update(item: Production) {
        productionName.text = item.name
        productionImage.download(image: item.imageURL)
    }
    
}
