//
//  NPCColorUtility.swift
//  NPCColorPicker
//
//  Created by Hasan D Edain and Andrew Bush on 12/6/15.
//  Copyright © 2015-2017 NPC Unlimited. All rights reserved.
//

import UIKit

open class NPCColorUtility {

    open static func colorWithRGBA(_ rgbaString: String)->UIColor {
        let colorString = cleanRGBAString(rgbaString)

        if colorString.length != 6 && colorString.length != 8 {
            return UIColor.white
        }

        let redPercent = NPCColorUtility.redPercentForRGBAString(colorString)
        let greenPercent = NPCColorUtility.greenPercentForRGBAString(colorString)
        let bluePercent = NPCColorUtility.bluePercentForRGBAString(colorString)
        let alphaPercent = NPCColorUtility.alphaPercentForRGBAString(colorString)

        let color = UIColor(red: redPercent, green: greenPercent, blue: bluePercent, alpha: alphaPercent)

        return color
    }

    open static func colorWithHex(_ hexString: String)->UIColor {
        let colorString = cleanHexString(hexString)

        if colorString.length != 6 && colorString.length != 8 {
            return UIColor.white
        }

        let alphaPercent:CGFloat = NPCColorUtility.alphaPercentForHexString(colorString)
        let redPercent = NPCColorUtility.redPercentForHexString(colorString)
        let greenPercent = NPCColorUtility.greenPercentForHexString(colorString)
        let bluePercent = NPCColorUtility.bluePercentForHexString(colorString)

        let color = UIColor(red: redPercent, green: greenPercent, blue: bluePercent, alpha: alphaPercent)

        return color
    }


    // MARK: - RGBA methods

    static func cleanRGBAString(_ rgbaString: String) -> NSString {
        var cString:NSString = rgbaString.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased() as NSString

        if cString.length != 6 && cString.length != 8 {
            cString = "";
        }

        return cString
    }

    open static func redPercentForRGBAString(_ colorString: NSString) -> CGFloat {
        let redString = colorString.substring(to: 2)
        let redPercent = NPCColorUtility.rgbaPercentForString(redString)

        return redPercent
    }

    open static func greenPercentForRGBAString(_ colorString: NSString) -> CGFloat {
        let greenRange = NSMakeRange(2, 2)
        let greenString = colorString.substring(with: greenRange)
        let greenPercent = NPCColorUtility.rgbaPercentForString(greenString)

        return greenPercent
    }

    open static func bluePercentForRGBAString(_ colorString: NSString) -> CGFloat {
        let blueRange = NSMakeRange(4, 2)
        let blueString = colorString.substring(with: blueRange)

        let bluePercent = NPCColorUtility.rgbaPercentForString(blueString)

        return bluePercent
    }

    open static func alphaPercentForRGBAString(_ colorString: NSString) -> CGFloat {
        var alphaPercent:CGFloat = 1.0

        if colorString.length == 8 {
            let alphaRange = NSMakeRange(6, 2)
            let alphaString = colorString.substring(with: alphaRange)

            alphaPercent = NPCColorUtility.rgbaPercentForString(alphaString)
        }

        return alphaPercent
    }

    open static func rgbaPercentForString(_ string: String)->CGFloat {
        var percentNumerator:Int = 0
        Scanner(string: string).scanInt(&percentNumerator)
        let percent = CGFloat(percentNumerator) / CGFloat(255.0)

        return percent
    }

    // MARK: - Hex methods


    static func cleanHexString(_ hexString: String) -> NSString {
        var cString:NSString = hexString.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased() as NSString

        if (cString.hasPrefix("#")) {
            cString = cString.substring(from: 1) as NSString
        }

        if cString.length != 6 && cString.length != 8 {
            cString = "";
        }

        return cString
    }

    open static func redPercentForHexString(_ colorString: NSString) -> CGFloat {
        let redString = colorString.substring(to: 2)
        let redPercent = NPCColorUtility.hexPercentForString(redString)

        return redPercent
    }

    open static func greenPercentForHexString(_ colorString: NSString) -> CGFloat {
        let greenRange = NSMakeRange(2, 2)
        let greenString = colorString.substring(with: greenRange)
        let greenPercent = NPCColorUtility.hexPercentForString(greenString)

        return greenPercent
    }

    open static func bluePercentForHexString(_ colorString: NSString) -> CGFloat {
        let blueRange = NSMakeRange(4, 2)
        let blueString = colorString.substring(with: blueRange)
        let bluePercent = NPCColorUtility.hexPercentForString(blueString)

        return bluePercent
    }

    open static func alphaPercentForHexString(_ colorString: NSString) -> CGFloat {
        var alphaPercent:CGFloat = 1.0

        if colorString.length == 8 {
            let alphaRange = NSMakeRange(6, 2)
            let alphaString = colorString.substring(with: alphaRange)
            alphaPercent = NPCColorUtility.hexPercentForString(alphaString)
        }

        return alphaPercent
    }


    open static func hexPercentForString(_ string: String)->CGFloat {
        var percentNumerator:CUnsignedInt = 0
        Scanner(string: string).scanHexInt32(&percentNumerator)
        let percent = CGFloat(percentNumerator) / CGFloat(255.0)

        return percent
    }

}
