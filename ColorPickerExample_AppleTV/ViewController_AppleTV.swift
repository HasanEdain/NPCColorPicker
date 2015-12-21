//
//  ViewController_AppleTV.swift
//  ColorPickerExample_AppleTV
//
//  Created by Sam Warfield on 12/18/15.
//  Copyright © 2015 NPC Unlimited. All rights reserved.
//

import UIKit

import NPCColorPicker_AppleTV

class ViewController_AppleTV: UIViewController, NPCColorPickerViewDelegate {

    let fiveColorSet = ["ffffff", "ff0000", "00ff00", "0000ff", "000000"]
    let twelveColorSet = ["fe7923", "fd0d1b", "bf1698", "941abe", "6819bd", "1024fc", "1ec0a8", "1dbb20", "c7f131", "e8ea34", "fad931", "feb92b"]

    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var embedView: UIView!
    @IBOutlet weak var colorSelectionSegmentControl: UISegmentedControl!
    @IBOutlet weak var horizontalSpacingSegment: UISegmentedControl!
    @IBOutlet weak var verticalSpacingSegment: UISegmentedControl!
    @IBOutlet var focusViews: [UIView]!

    var colorPicker = NPCColorPicker()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        colorView.backgroundColor = NPCColorUtility.colorWithHex("#00ff00ff")
        colorView.layer.borderColor = UIColor.blackColor().CGColor
        colorView.layer.borderWidth = 4.0
        colorView.layer.cornerRadius = 8
        colorView.layer.masksToBounds = true
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        // Step 3) place colorPicker in Embed View (see Main Storyboard for example)
        self.colorPicker.embedColorPickerInView(self.embedView, forDelegate: self)

        // Setup defaults
        self.colorPicker.changeDiameter(200)
        self.colorPicker.changeMaskStyle(.square)
        self.colorPicker.changeColorSet(fiveColorSet)

        setupFocusGuides()
    }

    func setupFocusGuides() {
        focusViews.forEach { view in
            let focusGuide = UIFocusGuide()

            view.addLayoutGuide(focusGuide)

            // Anchor the top left of the focus guide.
            focusGuide.leftAnchor.constraintEqualToAnchor(view.leftAnchor).active = true
            focusGuide.topAnchor.constraintEqualToAnchor(view.topAnchor).active = true

            // Anchor the width and height of the focus guide.
            focusGuide.widthAnchor.constraintEqualToAnchor(view.widthAnchor).active = true
            focusGuide.heightAnchor.constraintEqualToAnchor(view.heightAnchor).active = true

            focusGuide.preferredFocusedView = colorSelectionSegmentControl
        }
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

    @IBAction func shapeSelected(sender: UISegmentedControl) {
        let shapeSegment = sender

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

    @IBAction func sizeSelected(sender: UISegmentedControl) {
        var size: CGFloat

        switch sender.selectedSegmentIndex {
        case 0:
            size = 200
        case 1:
            size = 300
        case 2:
            size = 400
        default:
            size = 300
        }

        // You can set the size of the touch targets for the colors
        self.colorPicker.changeDiameter(size)
    }

    @IBAction func horizontalSpaceSelected(sender: AnyObject) {
        updatePaleteSpacing()
    }

    @IBAction func verticalSpaceSelected(sender: AnyObject) {
        updatePaleteSpacing()
    }

    func updatePaleteSpacing() {
        let horizontalSpace: CGFloat
        let verticalSpace:CGFloat
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
            verticalSpace = 0
            break
        case 1:
            verticalSpace = 8
            break
        default:
            verticalSpace = 8
            break
        }

        // You can change the insets between cells
        self.colorPicker.changeSpaceBetweenColors(verticalSpace, columns: horizontalSpace)
    }

    @IBAction func colorsSelected(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.colorPicker.changeColorSet(fiveColorSet)
        case 1:
            self.colorPicker.changeColorSet(twelveColorSet)
        case 2:
            self.colorPicker.changeColorToGradient("ff0000", endColor: "0000ff", steps: 32)
        default:
            break
        }
    }
}
