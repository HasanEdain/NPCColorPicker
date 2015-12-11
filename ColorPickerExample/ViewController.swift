//
//  ViewController.swift
//  ColorPickerExample
//
//  Created by Hasan D Edain and Andrew Bush on 12/6/15.
//  Copyright © 2015 NPC Unlimited. All rights reserved.
//

import UIKit

import NPCColorPicker

// Step 1) Adopt the NPCColorPickerViewDelegate
class ViewController: UIViewController, NPCColorPickerViewDelegate {

    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var embedView: UIView!
    // Step 2) Initilze NPCColorPicker
    var colorPicker = NPCColorPicker()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        colorView.backgroundColor = NPCColorUtility.colorWithHex("#00ff00ff")
    }

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        // Step 3) place colorPicker in Embed View (see Main Storyboard for example
        self.colorPicker.embedColorPickerInView(self.embedView, forDelegate: self)

        // ************ Optional configuration  ************

        // You can set the colors to a gradient of your choosing
        self.colorPicker.changeColorToGradient("ff0000", endColor: "0000ff", steps: 32)

        // You can use your own set of colors
        //self.colorPicker.changeColorSet(["ffffff","ff0000","00ff00","0000ff","000000"])

        // You can set the size of the touch targets for the colors
        self.colorPicker.changeDiameter(32.0)

        // You can change the shape of the touch targets for the colors
        self.colorPicker.changeMaskStyle(.circle)

        // You can change the insets between cells
        self.colorPicker.changeSpaceBetweenColors(8.0, columns: 8.0)

    }

    // Step 4) implement delegate
    // MARK: - NPCColorPickerViewDelegate
    func colorChosen(color: UIColor) {
        self.colorView.backgroundColor = color
    }

    // MARK: - Actions
    @IBAction func pickerPressed(sender: AnyObject) {
        colorPicker.toggleVisibility()
    }
}


