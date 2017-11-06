//
//  NPCColorPicker.swift
//  NPCColorPicker
//
//  Created by Hasan D Edain and Andrew Bush on 12/9/15.
//  Copyright © 2015-2017 NPC Unlimited. All rights reserved.
//

import Foundation

open class NPCColorPicker {
    var colorPickerViewController: NPCColorPickerViewController?

    public init() {
        colorPickerViewController = NPCColorPickerViewController()
    }

     open func embedColorPickerInView(_ view:UIView, forDelegate delegate:NPCColorPickerViewDelegate) -> NPCColorPicker {
        colorPickerViewController = NPCColorPickerViewController.embedColorPickerInView(view, forDelegate: delegate)

        return self;
    }

    open func toggleVisibility() {
        colorPickerViewController?.toggleVisibility()
    }

    open func changeDiameter(_ diameter: CGFloat) {
        colorPickerViewController?.changeDiameter(diameter)
    }

    open func changeMaskStyle(_ style: NPCColorPickerMask) {
        colorPickerViewController?.changeMaskStyle(style)
    }

    open func changeColorSet(_ colorArrayString: [String]) {
        colorPickerViewController?.changeColorSet(colorArrayString)
    }

    open func changeColorToGradient(_ startColor: String, endColor: String, steps: Int) {
        colorPickerViewController?.changeColorToGradient(startColor, endColor: endColor, steps: steps)
    }

    open func changeColorToGradientArray(_ colorStrings: [String], steps: Int) {
        colorPickerViewController?.changeColorToGradientArray(colorStrings, steps: steps)
    }

    open func changeSpaceBetweenColors(_ rows: CGFloat, columns: CGFloat) {
        colorPickerViewController?.changeSpaceBetweenColors(rows, columns: columns)
    }
}
