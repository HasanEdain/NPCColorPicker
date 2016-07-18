//
//  NPCColorPickerViewController.swift
//  NPCColorPicker
//
//  Created by Hasan D Edain and Andrew Bush on 12/6/15.
//  Copyright © 2015 NPC Unlimited. All rights reserved.
//

import UIKit

#if os(tvOS)
let bundleIdentifer = "com.npc.NPCColorPicker-AppleTV"
let storyboardIdentifer = "NPCColorPicker_AppleTV"
#else
let bundleIdentifer = "com.npc.NPCColorPicker"
let storyboardIdentifer = "NPCColorPicker"
#endif

let cellReuseIdentifier = "Cell"
let viewControllerIdentifier = "NPCColorPickerViewController"

public protocol NPCColorPickerViewDelegate {
    func colorChosen(color: UIColor)
}

@IBDesignable class NPCColorPickerViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    var chipEdge = CGFloat(48.0)
    var rowSpace = CGFloat(8.0)
    var columnSpace = CGFloat(8.0)

    var maskType = NPCColorPickerMask.square
    var colorArray = NPCPaleteUtility.twelveColorWheel()
    @IBInspectable @IBOutlet weak var colorPickerCollection: UICollectionView!
    var colorPickerDelegate: NPCColorPickerViewDelegate?

    // MARK: - Collection View
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.colorArray.count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var collectionCell = collectionView.dequeueReusableCellWithReuseIdentifier(cellReuseIdentifier, forIndexPath: indexPath)

        if let cell = collectionCell as? NPCColorPickerCollectionViewCell {
            let color = self.colorArray[indexPath.row]
            let view = cell.contentView

            view.layer.masksToBounds = true
            switch maskType {
            case .square:
                view.layer.cornerRadius = 0.0
                break
            case .roundedRect:
                view.layer.cornerRadius = chipEdge / 6.0
                break
            case .circle:
                view.layer.cornerRadius = chipEdge / 2.0
                break
            }
            cell.color = color
            collectionCell = cell
        }
        return collectionCell
    }

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if let delegate = self.colorPickerDelegate {
            let selectedColor = colorArray[indexPath.row]
            delegate.colorChosen(selectedColor)
        }
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(self.chipEdge, self.chipEdge)
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return columnSpace;
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return rowSpace;
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        let width = self.colorPickerCollection.bounds.size.width
        let widthRemainder = width % self.chipEdge
        let widthPad = widthRemainder / 2.0
        
        let height = self.colorPickerCollection.bounds.size.height
        let heightRemainder = height % self.chipEdge
        let heightpad = heightRemainder / 2.0
        
        return UIEdgeInsetsMake(heightpad, widthPad, heightpad, widthPad)
    }

    // MARK: - NPCColorPickerViewDelegate
    func pickerDelegate(delegate: NPCColorPickerViewDelegate) {
        colorPickerDelegate = delegate
    }

    // MARK: - Public
    func toggleVisibility() {
        self.colorPickerCollection.hidden = !self.colorPickerCollection.hidden
    }

    static func embedColorPickerInView(view:UIView, forDelegate delegate:NPCColorPickerViewDelegate) -> NPCColorPickerViewController? {
        let bundle = NSBundle(identifier: bundleIdentifer)
        let myStoryboard = UIStoryboard(name: storyboardIdentifer, bundle: bundle)

        if let controller = myStoryboard.instantiateViewControllerWithIdentifier(viewControllerIdentifier) as? NPCColorPickerViewController {
            controller.pickerDelegate(delegate);
            view.addSubview(controller.view)
            controller.view.frame = view.bounds

            return controller;
        }
        return nil;
    }

    func changeDiameter(diameter: CGFloat) {
        self.chipEdge = diameter;
        self.colorPickerCollection.reloadData()
    }

    func changeMaskStyle(style: NPCColorPickerMask) {
        maskType = style
        self.colorPickerCollection.reloadData()
    }

    func changeColorSet(colorArrayString: [String]) {
        colorArray = NPCPaleteUtility.colorArrayWithHexStringArray(colorArrayString)
        self.colorPickerCollection.reloadData()
    }

    func changeColorToGradient(startColor: String, endColor: String, steps: Int) {
        colorArray = NPCPaleteUtility.colorArrayWithGradient(startColor, endColor: endColor, steps: steps)
        self.colorPickerCollection.reloadData()
    }

    func changeColorToGradientArray(colorStrings: [String], steps: Int) {
        colorArray = NPCPaleteUtility.colorArrayWithColorStringArray(colorStrings, steps: steps)
        self.colorPickerCollection.reloadData()
    }

    func changeSpaceBetweenColors(rows: CGFloat, columns: CGFloat) {
        self.rowSpace = rows
        self.columnSpace = columns
        
        self.colorPickerCollection.reloadData()
    }
    
}
