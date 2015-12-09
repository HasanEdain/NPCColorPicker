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
        [NPCColorUtility.colorWithHex("fe7923"),
        NPCColorUtility.colorWithHex("fd0d1b"),
        NPCColorUtility.colorWithHex("bf1698"),
        NPCColorUtility.colorWithHex("941abe"),
        NPCColorUtility.colorWithHex("6819bd"),
        NPCColorUtility.colorWithHex("1024fc"),
        NPCColorUtility.colorWithHex("1ec0a8"),
        NPCColorUtility.colorWithHex("1dbb20"),
        NPCColorUtility.colorWithHex("c7f131"),
        NPCColorUtility.colorWithHex("e8ea34"),
        NPCColorUtility.colorWithHex("fad931"),
        NPCColorUtility.colorWithHex("feb92b")]

        return colorArray
    }

    public static func colorArrayWithHexStringArray(hexStringArray: [String]) -> [UIColor] {
        var colorArray = [UIColor]()
        for hexString in hexStringArray {
            let color = NPCColorUtility.colorWithHex(hexString)
            colorArray.append(color)
        }

        return colorArray
    }

    public static func colorArrayWithGradient(startColor: String, endColor: String, steps: Int) -> [UIColor] {
        var colorArray = [UIColor]()

        let startRed = NPCColorUtility.redPercentForString(startColor)
        let startGreen = NPCColorUtility.greenPercentForString(startColor)
        let startBlue = NPCColorUtility.bluePercentForString(startColor)
        let startAlpha = NPCColorUtility.alphaPercentForString(startColor)

        let endRed = NPCColorUtility.redPercentForString(endColor)
        let endGreen = NPCColorUtility.greenPercentForString(endColor)
        let endBlue = NPCColorUtility.bluePercentForString(endColor)
        let endAlpha = NPCColorUtility.alphaPercentForString(endColor)

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

}
