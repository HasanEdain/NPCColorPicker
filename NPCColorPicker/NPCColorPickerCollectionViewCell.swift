//
//  NPCColorPickerCollectionViewCell.swift
//  NPCColorPicker
//
//  Created by Sam Warfield on 12/20/15.
//  Copyright © 2015-2017 NPC Unlimited. All rights reserved.
//

import UIKit

@IBDesignable
class NPCColorPickerCollectionViewCell: UICollectionViewCell
{
    @IBOutlet weak var imageView: UIImageView!

    @IBInspectable var color: UIColor? {
        didSet {
            if let imageView = imageView, let color = color
            {
                imageView.image = UIImage.imageWithColor(color)
            }
            else
            {
                contentView.backgroundColor = color
            }
        }
    }
}

extension UIImage {
    class func imageWithColor(_ color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 1, height: 1), false, 0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
