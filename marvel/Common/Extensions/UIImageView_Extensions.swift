//
//  UIImageView_Extensions.swift
//  marvel
//
//  Created by Fernando Luiz Goulart on 01/01/21.
//  Copyright © 2021 Fernando Luiz Goulart. All rights reserved.
//

import Kingfisher

extension UIImageView {
    func download(image url: String) {
        guard let imageURL = URL(string: url) else {
            self.image = UIImage(named: "SquareImage")
            return
        }
        let image = UIImage(named: "SquareImage")
        self.kf.setImage(with: ImageResource(downloadURL: imageURL), placeholder: image)
    }
}
