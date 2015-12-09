//
//  NPCColorUtility.swift
//  NPCColorPicker
//
//  Created by Hasan D Edain on 12/6/15.
//  Copyright © 2015 NPC Unlimited. All rights reserved.
//

import UIKit

public class NPCColorUtility {

    public static func colorWithHex(hexString: String)->UIColor {
        let colorString = cleanHexString(hexString)

        if (colorString.length != 6 && colorString.length != 8) {
            return UIColor.whiteColor()
        }

        let alphaPercent:CGFloat = NPCColorUtility.alphaPercentForString(colorString)
        let redPercent = NPCColorUtility.redPercentForString(colorString)
        let greenPercent = NPCColorUtility.greenPercentForString(colorString)
        let bluePercent = NPCColorUtility.bluePercentForString(colorString)

        let color = UIColor(red: redPercent, green: greenPercent, blue: bluePercent, alpha: alphaPercent)

        return color
    }

    static func cleanHexString(hexString: String) -> NSString {
        var cString:NSString = hexString.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).uppercaseString

        if (cString.hasPrefix("#")) {
            cString = cString.substringFromIndex(1)
        }

        if cString.length != 6 && cString.length != 8 {
            cString = "";
        }

        return cString
    }

    public static func redPercentForString(colorString: NSString) -> CGFloat {
        let redString = colorString.substringToIndex(2)
        let redPercent = NPCColorUtility.percentForString(redString)

        return redPercent
    }

    public static func greenPercentForString(colorString: NSString) -> CGFloat {
        let greenRange = NSMakeRange(2, 2)
        let greenString = colorString.substringWithRange(greenRange)
        let greenPercent = NPCColorUtility.percentForString(greenString)

        return greenPercent
    }

    public static func bluePercentForString(colorString: NSString) -> CGFloat {
        let blueRange = NSMakeRange(4, 2)
        let blueString = colorString.substringWithRange(blueRange)
        let bluePercent = NPCColorUtility.percentForString(blueString)

        return bluePercent
    }

    public static func alphaPercentForString(colorString: NSString) -> CGFloat {
        var alphaPercent:CGFloat = 1.0

        if colorString.length == 8 {
            let alphaRange = NSMakeRange(6, 2)
            let alphaString = colorString.substringWithRange(alphaRange)
            alphaPercent = NPCColorUtility.percentForString(alphaString)
        }

        return alphaPercent
    }


    public static func percentForString(string:String)->CGFloat {
        var percentString:CUnsignedInt = 0
        NSScanner(string: string).scanHexInt(&percentString)
        let percent = CGFloat(percentString) / CGFloat(255.0)

        return percent
    }

}
