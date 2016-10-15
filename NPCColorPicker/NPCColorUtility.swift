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
        let colorString = cleanRGBAString(rgbaString: rgbaString)

        if colorString.length != 6 && colorString.length != 8 {
            return UIColor.white
        }

        let redPercent = NPCColorUtility.redPercentForRGBAString(colorString: colorString)
        let greenPercent = NPCColorUtility.greenPercentForRGBAString(colorString: colorString)
        let bluePercent = NPCColorUtility.bluePercentForRGBAString(colorString: colorString)
        let alphaPercent = NPCColorUtility.alphaPercentForRGBAString(colorString: colorString)

        let color = UIColor(red: redPercent, green: greenPercent, blue: bluePercent, alpha: alphaPercent)

        return color
    }

    public static func colorWithHex(hexString: String)->UIColor {
        let colorString = cleanHexString(hexString: hexString)

        if colorString.length != 6 && colorString.length != 8 {
            return UIColor.white
        }

        let alphaPercent:CGFloat = NPCColorUtility.alphaPercentForHexString(colorString: colorString)
        let redPercent = NPCColorUtility.redPercentForHexString(colorString: colorString)
        let greenPercent = NPCColorUtility.greenPercentForHexString(colorString: colorString)
        let bluePercent = NPCColorUtility.bluePercentForHexString(colorString: colorString)

        let color = UIColor(red: redPercent, green: greenPercent, blue: bluePercent, alpha: alphaPercent)

        return color
    }


    // MARK: - RGBA methods

    static func cleanRGBAString(rgbaString: String) -> NSString {
        var cString:NSString = rgbaString.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased() as NSString

        if cString.length != 6 && cString.length != 8 {
            cString = "";
        }

        return cString
    }

    public static func redPercentForRGBAString(colorString: NSString) -> CGFloat {
        let redString = colorString.substring(to: 2)
        let redPercent = NPCColorUtility.rgbaPercentForString(string: redString)

        return redPercent
    }

    public static func greenPercentForRGBAString(colorString: NSString) -> CGFloat {
        let greenRange = NSMakeRange(2, 2)
        let greenString = colorString.substring(with: greenRange)
        let greenPercent = NPCColorUtility.rgbaPercentForString(string: greenString)

        return greenPercent
    }

    public static func bluePercentForRGBAString(colorString: NSString) -> CGFloat {
        let blueRange = NSMakeRange(4, 2)
        let blueString = colorString.substring(with: blueRange)

        let bluePercent = NPCColorUtility.rgbaPercentForString(string: blueString)

        return bluePercent
    }

    public static func alphaPercentForRGBAString(colorString: NSString) -> CGFloat {
        var alphaPercent:CGFloat = 1.0

        if colorString.length == 8 {
            let alphaRange = NSMakeRange(6, 2)
            let alphaString = colorString.substring(with: alphaRange)

            alphaPercent = NPCColorUtility.rgbaPercentForString(string: alphaString)
        }

        return alphaPercent
    }

    public static func rgbaPercentForString(string: String)->CGFloat {
        var percentNumerator:Int = 0
        Scanner(string: string).scanInt(&percentNumerator)
        let percent = CGFloat(percentNumerator) / CGFloat(255.0)

        return percent
    }

    // MARK: - Hex methods


    static func cleanHexString(hexString: String) -> NSString {
        var cString:NSString = hexString.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased() as NSString

        if (cString.hasPrefix("#")) {
            cString = cString.substring(from: 1) as NSString
        }

        if cString.length != 6 && cString.length != 8 {
            cString = "";
        }

        return cString
    }

    public static func redPercentForHexString(colorString: NSString) -> CGFloat {
        let redString = colorString.substring(to: 2)
        let redPercent = NPCColorUtility.hexPercentForString(string: redString)

        return redPercent
    }

    public static func greenPercentForHexString(colorString: NSString) -> CGFloat {
        let greenRange = NSMakeRange(2, 2)
        let greenString = colorString.substring(with: greenRange)
        let greenPercent = NPCColorUtility.hexPercentForString(string: greenString)

        return greenPercent
    }

    public static func bluePercentForHexString(colorString: NSString) -> CGFloat {
        let blueRange = NSMakeRange(4, 2)
        let blueString = colorString.substring(with: blueRange)
        let bluePercent = NPCColorUtility.hexPercentForString(string: blueString)

        return bluePercent
    }

    public static func alphaPercentForHexString(colorString: NSString) -> CGFloat {
        var alphaPercent:CGFloat = 1.0

        if colorString.length == 8 {
            let alphaRange = NSMakeRange(6, 2)
            let alphaString = colorString.substring(with: alphaRange)
            alphaPercent = NPCColorUtility.hexPercentForString(string: alphaString)
        }

        return alphaPercent
    }


    public static func hexPercentForString(string: String)->CGFloat {
        var percentNumerator:CUnsignedInt = 0
        Scanner(string: string).scanHexInt32(&percentNumerator)
        let percent = CGFloat(percentNumerator) / CGFloat(255.0)

        return percent
    }

}
