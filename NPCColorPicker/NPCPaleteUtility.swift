//
//  NPCPaleteUtility.swift
//  NPCColorPicker
//
//  Created by Hasan D Edain and Andrew Bush on 12/6/15.
//  Copyright © 2015 NPC Unlimited. All rights reserved.
//

import UIKit

public class NPCPaleteUtility {

    public static func twelveColorWheel()->[UIColor] {
        let colorArray =
        [NPCColorUtility.colorWithHex(hexString: "fe7923"),
        NPCColorUtility.colorWithHex(hexString: "fd0d1b"),
        NPCColorUtility.colorWithHex(hexString: "bf1698"),
        NPCColorUtility.colorWithHex(hexString: "941abe"),
        NPCColorUtility.colorWithHex(hexString: "6819bd"),
        NPCColorUtility.colorWithHex(hexString: "1024fc"),
        NPCColorUtility.colorWithHex(hexString: "1ec0a8"),
        NPCColorUtility.colorWithHex(hexString: "1dbb20"),
        NPCColorUtility.colorWithHex(hexString: "c7f131"),
        NPCColorUtility.colorWithHex(hexString: "e8ea34"),
        NPCColorUtility.colorWithHex(hexString: "fad931"),
        NPCColorUtility.colorWithHex(hexString: "feb92b")]

        return colorArray
    }


    public static func colorArrayWithRGBAStringArray(hexStringArray: [String]) -> [UIColor] {
        var colorArray = [UIColor]()
        for hexString in hexStringArray {
            let color = NPCColorUtility.colorWithRGBA(rgbaString: hexString)
            colorArray.append(color)
        }

        return colorArray
    }

    public static func colorArrayWithHexStringArray(hexStringArray: [String]) -> [UIColor] {
        var colorArray = [UIColor]()
        for hexString in hexStringArray {
            let color = NPCColorUtility.colorWithHex(hexString: hexString)
            colorArray.append(color)
        }

        return colorArray
    }

    // These colors are specified in #ffffffff Hexidecimal form
    public static func colorArrayWithGradient(startColor: String, endColor: String, steps: Int) -> [UIColor] {
        var colorArray = [UIColor]()

        let startRed = NPCColorUtility.redPercentForHexString(colorString: startColor as NSString)
        let startGreen = NPCColorUtility.greenPercentForHexString(colorString: startColor as NSString)
        let startBlue = NPCColorUtility.bluePercentForHexString(colorString: startColor as NSString)
        let startAlpha = NPCColorUtility.alphaPercentForHexString(colorString: startColor as NSString)

        let endRed = NPCColorUtility.redPercentForHexString(colorString: endColor as NSString)
        let endGreen = NPCColorUtility.greenPercentForHexString(colorString: endColor as NSString)
        let endBlue = NPCColorUtility.bluePercentForHexString(colorString: endColor as NSString)
        let endAlpha = NPCColorUtility.alphaPercentForHexString(colorString: endColor as NSString)

        let redDelta = -1 * (startRed - endRed)
        let greenDelta = -1 * (startGreen - endGreen)
        let blueDelta = -1 * (startBlue - endBlue)
        let alphaDelta = -1 * (startAlpha - endAlpha)

        var redIncrement:CGFloat = 0.0
        if steps > 0 && redDelta != 0 {
            redIncrement = redDelta / CGFloat(steps)
        }

        var greenIncrement: CGFloat = 0.0
        if steps > 0 && greenDelta != 0 {
            greenIncrement = greenDelta / CGFloat(steps)
        }

        var blueIncrement: CGFloat = 0.0
        if steps > 0 && blueDelta != 0 {
            blueIncrement = blueDelta / CGFloat(steps)
        }

        var alphaIncrement: CGFloat = 0.0
        if steps > 0 && alphaDelta != 0 {
            alphaIncrement = alphaDelta / CGFloat(steps)
        }

        for step in 1...steps {
            let red = startRed + (redIncrement * CGFloat(step))
            let green = startGreen + (greenIncrement * CGFloat(step))
            let blue = startBlue + (blueIncrement * CGFloat(step))
            let alpha = startAlpha + (alphaIncrement * CGFloat(step))

            let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
            colorArray.append(color)
        }

        return colorArray
    }

    public static func colorArrayWithColorStringArray(colorStrings: [String], steps: Int)->[UIColor] {
        if colorStrings.count <= 0 {
            return [UIColor.white]
        } else if colorStrings.count == 1 {
            return NPCPaleteUtility.colorArrayWithGradient(startColor: colorStrings[0], endColor: "ffffff", steps: steps)
        } else {
            var gradients = [UIColor]()
            for index in 1...(colorStrings.count - 1){
                let start = colorStrings[index - 1]
                let end = colorStrings[index]
                var gradient = NPCPaleteUtility.colorArrayWithGradient(startColor: start, endColor: end, steps: steps)
                if index > 1 {
                    gradient.removeFirst()
                }
                gradients.append(contentsOf: gradient)
            }
            return gradients
        }
    }
}
