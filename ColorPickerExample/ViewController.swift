//
//  ViewController.swift
//  ColorPickerExample
//
//  Created by Hasan D Edain and Andrew Bush on 12/6/15.
//  Copyright © 2015-2017 NPC Unlimited. All rights reserved.
//

import UIKit

import NPCColorPicker

// Step 1) Adopt the NPCColorPickerViewDelegate
class ViewController: UIViewController, NPCColorPickerViewDelegate {

    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var embedView: UIView!
    @IBOutlet weak var horizontalSpacingSegment: UISegmentedControl!
    @IBOutlet weak var verticalSpacingSegment: UISegmentedControl!

    // Step 2) Initilze NPCColorPicker
    var colorPicker = NPCColorPicker()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        colorView.backgroundColor = NPCColorUtility.colorWithHex("#00ff00ff")
        colorView.layer.borderColor = UIColor.black.cgColor
        colorView.layer.borderWidth = 4.0
        colorView.layer.cornerRadius = 8
        colorView.layer.masksToBounds = true
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Step 3) place colorPicker in Embed View (see Main Storyboard for example)
        _ = self.colorPicker.embedColorPickerInView(self.embedView, forDelegate: self)
        updatePaleteSpacing()
    }

    // Step 4) implement delegate
    // MARK: - NPCColorPickerViewDelegate
    func colorChosen(_ color: UIColor) {
        self.colorView.backgroundColor = color
    }

    // MARK: - Actions
    @IBAction func pickerPressed(_ sender: AnyObject) {
        colorPicker.toggleVisibility()
    }

    @IBAction func shapeSelected(_ sender: AnyObject) {
        let shapeSegment = sender as! UISegmentedControl

        var shape = NPCColorPickerMask.square

        switch shapeSegment.selectedSegmentIndex {
        case 0:
            shape = .square
            break
        case 1:
            shape = .roundedRect
            break
        case 2:
            shape = .circle
            break
        default:
            shape = .square
            break
        }

        // You can change the shape of the touch targets for the colors
        self.colorPicker.changeMaskStyle(shape)
    }

    @IBAction func sizeSelected(_ sender: AnyObject) {
        let sizeSegment = sender as! UISegmentedControl

        var size: CGFloat

        switch sizeSegment.selectedSegmentIndex {
        case 0:
            size = 32
            break
        case 1:
            size = 48
            break
        case 2:
            size = 64
            break
        default:
            size = 48
            break
        }

        // You can set the size of the touch targets for the colors
        self.colorPicker.changeDiameter(size)
    }

    @IBAction func horizontalSpaceSelected(_ sender: AnyObject) {
        updatePaleteSpacing()
    }

    @IBAction func verticalSpaceSelected(_ sender: AnyObject) {
        updatePaleteSpacing()
    }

    func updatePaleteSpacing() {
        let horizontalSpace: CGFloat
        let verticalSapace:CGFloat
        switch horizontalSpacingSegment.selectedSegmentIndex {
        case 0:
            horizontalSpace = 0
            break
        case 1:
            horizontalSpace = 8
            break
        default:
            horizontalSpace = 8
            break
        }

        switch verticalSpacingSegment.selectedSegmentIndex {
        case 0:
            verticalSapace = 0
            break
        case 1:
            verticalSapace = 8
            break
        default:
            verticalSapace = 8
            break
        }

        // You can change the insets between cells
        self.colorPicker.changeSpaceBetweenColors(verticalSapace, columns: horizontalSpace)
    }

    @IBAction func colorsSelected(_ sender: AnyObject) {
        let colorSegment = sender as! UISegmentedControl

        switch colorSegment.selectedSegmentIndex {
        case 0:
            self.colorPicker.changeColorSet(["ffffff", "ff0000", "00ff00", "0000ff", "000000"])
            break
        case 1:
            self.colorPicker.changeColorSet(["fe7923", "fd0d1b", "bf1698", "941abe", "6819bd", "1024fc", "1ec0a8", "1dbb20", "c7f131", "e8ea34", "fad931", "feb92b"])
            break
        case 2:
            self.colorPicker.changeColorToGradient("ff0000", endColor: "0000ff", steps: 32)
            break
        case 3:
            self.colorPicker.changeColorToGradientArray(["ffffff","000000","ff0000","00ff00","0000ff"], steps: 16)
            break
        default:
            break
        }
    }
}


