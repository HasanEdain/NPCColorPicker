# NPCColorPicker
This is a lightweight color picker for iOS. Written in modern swift, delivered as a framework

Simple use:
1. Download code

2. Compile Framework

3. Add Framework to your project

4. Add a UIView that will contain the colors (don't forget to constrain the view)

5. Adopt the NPCColorPickerViewDelegate protocol
>     class ViewController: UIViewController, NPCColorPickerViewDelegate
6. Make and initialize an NPCColorPicker variable in your viewController: 
>     var colorPicker = NPCColorPicker()

7. Place the pickerView in your view: 
>     self.colorPicker.embedColorPickerInView(self.embedView, forDelegate: self)

8. Customize as desired
>        You can set the colors to a gradient of your choosing
>        self.colorPicker.changeColorToGradient("ff0000", endColor: "0000ff", steps: 32)
>
>        You can use your own set of colors (Alpha and hash tag #ffffffff is also supported)
>        self.colorPicker.changeColorSet(["ffffff","ff0000","00ff00","0000ff","000000"])
>
>        You can set the size of the touch targets for the colors
>        self.colorPicker.changeDiameter(32.0)
>
>        You can change the shape of the touch targets for the colors
>        self.colorPicker.changeMaskStyle(.roundedRect)
>        .square, and .circle are provided as well

9. Implement the single delegate method:
>	    func colorChosen(color: UIColor) {
>               self.colorView.backgroundColor = color
>       }
    
Now you have a color picker, what you do with it is up to you.