//
//  NPCColorPickerCollectionViewCell.swift
//  NPCColorPicker
//
//  Created by Sam Warfield on 12/20/15.
//  Copyright © 2015 NPC Unlimited. All rights reserved.
//

import UIKit

class NPCColorPickerCollectionViewCell: UICollectionViewCell
{
    @IBOutlet weak var imageView: UIImageView!

    var color: UIColor? {
        didSet {
            if let imageView = imageView, color = color
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
    class func imageWithColor(color: UIColor) -> UIImage {
        let rect = CGRectMake(0, 0, 1, 1)
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(1, 1), false, 0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}