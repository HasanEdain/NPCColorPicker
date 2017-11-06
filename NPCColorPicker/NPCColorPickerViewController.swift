//
//  NPCColorPickerViewController.swift
//  NPCColorPicker
//
//  Created by Hasan D Edain and Andrew Bush on 12/6/15.
//  Copyright © 2015-2017 NPC Unlimited. All rights reserved.
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
    func colorChosen(_ color: UIColor)
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
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.colorArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath)

        if let cell = collectionCell as? NPCColorPickerCollectionViewCell {
            let color = self.colorArray[(indexPath as NSIndexPath).row]
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

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let delegate = self.colorPickerDelegate {
            let selectedColor = colorArray[(indexPath as NSIndexPath).row]
            delegate.colorChosen(selectedColor)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.chipEdge, height: self.chipEdge)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return columnSpace;
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return rowSpace;
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let width = self.colorPickerCollection.frame.size.width
        let remainder = width.truncatingRemainder(dividingBy: self.chipEdge)
        let pad = remainder / 2.0

        return UIEdgeInsetsMake(0, pad, 0, pad)
    }

    // MARK: - NPCColorPickerViewDelegate
    func pickerDelegate(_ delegate: NPCColorPickerViewDelegate) {
        colorPickerDelegate = delegate
    }

    // MARK: - Public
    func toggleVisibility() {
        self.colorPickerCollection.isHidden = !self.colorPickerCollection.isHidden
    }

    static func embedColorPickerInView(_ view:UIView, forDelegate delegate:NPCColorPickerViewDelegate) -> NPCColorPickerViewController? {
        let bundle = Bundle(identifier: bundleIdentifer)
        let myStoryboard = UIStoryboard(name: storyboardIdentifer, bundle: bundle)

        if let controller = myStoryboard.instantiateViewController(withIdentifier: viewControllerIdentifier) as? NPCColorPickerViewController {
            controller.pickerDelegate(delegate);
            view.addSubview(controller.view)
            controller.view.frame = view.bounds

            return controller;
        }
        return nil;
    }

    func changeDiameter(_ diameter: CGFloat) {
        self.chipEdge = diameter;
        self.colorPickerCollection.reloadData()
    }

    func changeMaskStyle(_ style: NPCColorPickerMask) {
        maskType = style
        self.colorPickerCollection.reloadData()
    }

    func changeColorSet(_ colorArrayString: [String]) {
        colorArray = NPCPaleteUtility.colorArrayWithHexStringArray(colorArrayString)
        self.colorPickerCollection.reloadData()
    }

    func changeColorToGradient(_ startColor: String, endColor: String, steps: Int) {
        colorArray = NPCPaleteUtility.colorArrayWithGradient(startColor, endColor: endColor, steps: steps)
        self.colorPickerCollection.reloadData()
    }

    func changeColorToGradientArray(_ colorStrings: [String], steps: Int) {
        colorArray = NPCPaleteUtility.colorArrayWithColorStringArray(colorStrings, steps: steps)
        self.colorPickerCollection.reloadData()
    }

    func changeSpaceBetweenColors(_ rows: CGFloat, columns: CGFloat) {
        self.rowSpace = rows
        self.columnSpace = columns
        
        self.colorPickerCollection.reloadData()
    }
    
}
