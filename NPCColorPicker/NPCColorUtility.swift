//
//  NPCColorUtility.swift
//  NPCColorPicker
//
//  Created by Hasan D Edain and Andrew Bush on 12/6/15.
//  Copyright © 2015 NPC Unlimited. All rights reserved.
//

import UIKit

public class NPCColorUtility {

    public static func colorWithRGBA(rgbaString: String)->UIColor {
        let colorString = cleanRGBAString(rgbaString)

        if colorString.length != 6 && colorString.length != 8 {
            return UIColor.whiteColor()
        }

        let redPercent = NPCColorUtility.redPercentForRGBAString(colorString)
        let greenPercent = NPCColorUtility.greenPercentForRGBAString(colorString)
        let bluePercent = NPCColorUtility.bluePercentForRGBAString(colorString)
        let alphaPercent = NPCColorUtility.alphaPercentForRGBAString(colorString)

        let color = UIColor(red: redPercent, green: greenPercent, blue: bluePercent, alpha: alphaPercent)

        return color
    }

    public static func colorWithHex(hexString: String)->UIColor {
        let colorString = cleanHexString(hexString)

        if colorString.length != 6 && colorString.length != 8 {
            return UIColor.whiteColor()
        }

        let alphaPercent:CGFloat = NPCColorUtility.alphaPercentForHexString(colorString)
        let redPercent = NPCColorUtility.redPercentForHexString(colorString)
        let greenPercent = NPCColorUtility.greenPercentForHexString(colorString)
        let bluePercent = NPCColorUtility.bluePercentForHexString(colorString)

        let color = UIColor(red: redPercent, green: greenPercent, blue: bluePercent, alpha: alphaPercent)

        return color
    }


    // MARK: - RGBA methods

    static func cleanRGBAString(rgbaString: String) -> NSString {
        var cString:NSString = rgbaString.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).uppercaseString

        if cString.length != 6 && cString.length != 8 {
            cString = "";
        }

        return cString
    }

    public static func redPercentForRGBAString(colorString: NSString) -> CGFloat {
        let redString = colorString.substringToIndex(2)
        let redPercent = NPCColorUtility.rgbaPercentForString(redString)

        return redPercent
    }

    public static func greenPercentForRGBAString(colorString: NSString) -> CGFloat {
        let greenRange = NSMakeRange(2, 2)
        let greenString = colorString.substringWithRange(greenRange)
        let greenPercent = NPCColorUtility.rgbaPercentForString(greenString)

        return greenPercent
    }

    public static func bluePercentForRGBAString(colorString: NSString) -> CGFloat {
        let blueRange = NSMakeRange(4, 2)
        let blueString = colorString.substringWithRange(blueRange)

        let bluePercent = NPCColorUtility.rgbaPercentForString(blueString)

        return bluePercent
    }

    public static func alphaPercentForRGBAString(colorString: NSString) -> CGFloat {
        var alphaPercent:CGFloat = 1.0

        if colorString.length == 8 {
            let alphaRange = NSMakeRange(6, 2)
            let alphaString = colorString.substringWithRange(alphaRange)

            alphaPercent = NPCColorUtility.rgbaPercentForString(alphaString)
        }

        return alphaPercent
    }

    public static func rgbaPercentForString(string: String)->CGFloat {
        var percentNumerator:Int = 0
        NSScanner(string: string).scanInteger(&percentNumerator)
        let percent = CGFloat(percentNumerator) / CGFloat(255.0)

        return percent
    }

    // MARK: - Hex methods


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

    public static func redPercentForHexString(colorString: NSString) -> CGFloat {
        let redString = colorString.substringToIndex(2)
        let redPercent = NPCColorUtility.hexPercentForString(redString)

        return redPercent
    }

    public static func greenPercentForHexString(colorString: NSString) -> CGFloat {
        let greenRange = NSMakeRange(2, 2)
        let greenString = colorString.substringWithRange(greenRange)
        let greenPercent = NPCColorUtility.hexPercentForString(greenString)

        return greenPercent
    }

    public static func bluePercentForHexString(colorString: NSString) -> CGFloat {
        let blueRange = NSMakeRange(4, 2)
        let blueString = colorString.substringWithRange(blueRange)
        let bluePercent = NPCColorUtility.hexPercentForString(blueString)

        return bluePercent
    }

    public static func alphaPercentForHexString(colorString: NSString) -> CGFloat {
        var alphaPercent:CGFloat = 1.0

        if colorString.length == 8 {
            let alphaRange = NSMakeRange(6, 2)
            let alphaString = colorString.substringWithRange(alphaRange)
            alphaPercent = NPCColorUtility.hexPercentForString(alphaString)
        }

        return alphaPercent
    }


    public static func hexPercentForString(string: String)->CGFloat {
        var percentNumerator:CUnsignedInt = 0
        NSScanner(string: string).scanHexInt(&percentNumerator)
        let percent = CGFloat(percentNumerator) / CGFloat(255.0)

        return percent
    }

}
