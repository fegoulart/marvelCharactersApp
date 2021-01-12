//
//  UIImage+Extensions.swift
//  marvel
//
//  Created by Fernando Luiz Goulart on 12/01/21.
//  Copyright © 2021 Fernando Luiz Goulart. All rights reserved.
//
import UIKit

extension UIImage {
    func jpegData(withCompressionQuality quality: CGFloat) -> Data? {
        return autoreleasepool(invoking: {() -> Data? in
            return UIImageJPEGRepresentation(self, quality)
        })
    }
}
