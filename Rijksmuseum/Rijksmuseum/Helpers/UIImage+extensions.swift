//
//  UIImage+extensions.swift
//  Rijksmuseum
//
//  Created by Troian on 01.06.2023.
//

import Foundation
import CoreImage
import UIKit

extension UIImage {
    func imageWithAlpha(alpha: CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPointZero, blendMode: .normal, alpha: alpha)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    static func animatedImage(for systemName: String, duration: TimeInterval = 2, pointSize: CGFloat = 100) -> UIImage {
        let configuration = UIImage.SymbolConfiguration(pointSize: pointSize)
        let image = UIImage(systemName: systemName, withConfiguration: configuration)!
        var images: [UIImage] = []
        for i in 2...20 {
            images.append(image.imageWithAlpha(alpha: 1.0/CGFloat(i)))
        }
        images.append(contentsOf: images.reversed().dropLast())
        return UIImage.animatedImage(with: images, duration: duration)!
    }
}

extension UIImage {
    static var emptyData: UIImage {
        UIImage(systemName: "wifi.exclamationmark", withConfiguration: UIImage.SymbolConfiguration(pointSize: 60))!
    }
}
