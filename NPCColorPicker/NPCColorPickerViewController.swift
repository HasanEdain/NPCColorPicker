//
//  NPCColorPickerViewController.swift
//  NPCColorPicker
//
//  Created by Hasan D Edain and Andrew Bush on 12/6/15.
//  Copyright © 2015 NPC Unlimited. All rights reserved.
//

import UIKit

public protocol NPCColorPickerViewDelegate {
    func colorChosen(color: UIColor)
}

@IBDesignable class NPCColorPickerViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    var chipEdge = CGFloat(48.0)
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
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath)

        let color = self.colorArray[indexPath.row]
        cell.backgroundView?.layer.masksToBounds = true
        switch maskType {
        case .square:
            cell.layer.cornerRadius = 0.0
            break
        case .roundedRect:
            cell.layer.cornerRadius = chipEdge / 6.0
            break
        case .circle:
            cell.layer.cornerRadius = chipEdge / 2.0
            break
        }
        cell.backgroundColor = color

        return cell
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

    // MARK: - NPCColorPickerViewDelegate
    func pickerDelegate(delegate: NPCColorPickerViewDelegate) {
        colorPickerDelegate = delegate
    }

    // MARK: - Visibility
    func toggleVisibility() {
        self.colorPickerCollection.hidden = !self.colorPickerCollection.hidden
    }
    
    static func embedColorPickerInView(view:UIView, forDelegate delegate:NPCColorPickerViewDelegate)->NPCColorPickerViewController? {
        
        let bundle = NSBundle.init(identifier: "com.npc.NPCColorPicker")
        let myStoryboard = UIStoryboard.init(name: "NPCColorPicker", bundle: bundle)
        
        if let controller = myStoryboard.instantiateViewControllerWithIdentifier("NPCColorPickerViewController") as? NPCColorPickerViewController {
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

}
