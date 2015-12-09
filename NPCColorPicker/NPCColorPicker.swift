//
//  NPCColorPicker.swift
//  NPCColorPicker
//
//  Created by Hasan D Edain on 12/9/15.
//  Copyright © 2015 NPC Unlimited. All rights reserved.
//

import Foundation

public class NPCColorPicker {
    var colorPickerViewController: NPCColorPickerViewController?

    public init() {
        colorPickerViewController = NPCColorPickerViewController()
    }

     public func embedColorPickerInView(view:UIView, forDelegate delegate:NPCColorPickerViewDelegate) -> NPCColorPicker {
        colorPickerViewController = NPCColorPickerViewController.embedColorPickerInView(view, forDelegate: delegate)

        return self;
    }

    public func toggleVisibility() {
        colorPickerViewController?.toggleVisibility()
    }

    public func changeDiameter(diameter: CGFloat) {
        colorPickerViewController?.changeDiameter(diameter)
    }

    public func changeMaskStyle(style: NPCColorPickerMask) {
        colorPickerViewController?.changeMaskStyle(style)
    }

    public func changeColorSet(colorArrayString: [String]) {
        colorPickerViewController?.changeColorSet(colorArrayString)
    }

    public func changeColorToGradient(startColor: String, endColor: String, steps: Int) {
        colorPickerViewController?.changeColorToGradient(startColor, endColor: endColor, steps: steps)
    }
}
