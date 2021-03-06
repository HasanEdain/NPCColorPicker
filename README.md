# NPCColorPicker
## This is a lightweight color picker for iOS. Written in modern swift, delivered as a framework

* iOS 10.3+ target (you can adjust project to use older)
* tvOS Support (tvOS 10.2 and later)
* 100% Swift 4.0 code (almost no code changes for swift 3.1 if you need)
* Simple adoption
* Very lightweight (1 storyboard, no images)
* Bitcode enabled

>Note: Only the color chips are delivered by the framework, the button and the larger green chip are part of the example application.

![Default Configuration](https://github.com/HasanEdain/NPCColorPicker/blob/master/ReadmeScreenShots/DefaultConfig.png?raw=true)
![Custom Configuration](https://github.com/HasanEdain/NPCColorPicker/blob/master/ReadmeScreenShots/CustomConfig.png?raw=true)
![tvOS Multi Gradient Configuration](https://github.com/HasanEdain/NPCColorPicker/blob/master/ReadmeScreenShots/tvOSMultiGradient.png?raw=true)

##Simple use:
1. Download code

2. Compile Framework 
>  Can use Carthage here for iOS: github "HasanEdain/NPCColorPicker"

3. Add Framework to your project

4. Add a UIView that will contain the colors (don't forget to constrain the view)

5. Adopt the NPCColorPickerViewDelegate protocol
>     class ViewController: UIViewController, NPCColorPickerViewDelegate
6. Make and initialize an NPCColorPicker variable in your viewController: 
>     var colorPicker = NPCColorPicker()

7. Place the pickerView in your view: 
>     self.colorPicker.embedColorPickerInView(self.embedView, forDelegate: self)

8. Customize as desired
>        You can use your own set of colors (Alpha and hash tag #ffffffff is also supported)
>        self.colorPicker.changeColorSet(["ffffff","ff0000","00ff00","0000ff","000000"])
>
>        You can set the colors to a gradient of your choosing
>        self.colorPicker.changeColorToGradient("ff0000", endColor: "0000ff", steps: 32)
>
>        You van set an array of gradients:
>        self.colorPicker.changeColorToGradientArray(["ffffff","000000","ff0000","00ff00","0000ff"], steps: 16)
>
>        You can set the size of the touch targets for the colors
>        self.colorPicker.changeDiameter(32.0)
>
>        You can change the shape of the touch targets for the colors
>        self.colorPicker.changeMaskStyle(.roundedRect)
>        .square, and .circle are provided as well
>
>        You can change the space between rows and columns of colors.
>        self.colorPicker.changeSpaceBetweenColors(8.0, columns: 8.0)

9. Implement the single delegate method:
>	    func colorChosen(color: UIColor) {
>               self.colorView.backgroundColor = color
>       }
    
# Now you have a color picker.
What you do with it is up to you.

## Created by Hasan Edain and Andrew Bush
NPC Unlimited <http://npcunlimited.com>

Bush Software <http://www.bushsoftware.com>

### tvOS integration and example application completed by Sam Warfield

## Possible improvements:
### Documentation
* Fix Carthage for tvOS

### Features
* A method to provide a mask and or a frame for chips

### Tests
* Improve / Test install and configure
* Add unit tests.
* Add UI Tests
* Add Performance test

## Feedback
Please send feedback to <support@npcunlimited.com>
