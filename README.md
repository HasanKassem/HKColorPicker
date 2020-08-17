# HKColorPicker
![Cocoapods](https://img.shields.io/cocoapods/v/HKColorPicker)
![Cocoapods platforms](https://img.shields.io/cocoapods/p/HKColorPicker)
![Cocoapods](https://img.shields.io/cocoapods/l/HKColorPicker)

![](https://media.giphy.com/media/jTqtcw99mBmOkUx6hk/giphy.gif)
## Description
`HKColorPicker` is  simple control for selecting a color from a small set of predefined colors.


## Usage
### Storyboard
Drag a `UIView` object and set the class to `HKColorPickerView`. 
Make sure to set the size of the view so it displays correctly. Now you can customize the 
properties in the IB as shown in the figures.
To be notified when the a color is selected, create an `@IBAction` on `ValueChanged` control event.

![Imgur](https://imgur.com/axb7Tnr.png)

Note that colors can be only set via code, and number of buttons will change according to the number of colors. The numbers property in the storyboard is only for preview.

### Code
```swift
	let picker = HKColorPickerView()
	picker.colors = [UIColor.red, UIColor.blue, UIColor.green]
	colorPicker.addTarget(self, action: #selector(updateColor), for: .valueChanged)
```

## Properties

```swift
	///number of buttons, only for storyboard
	@IBInspectable public var number: Int = 6
	
	///spacing between buttons if centered
	@IBInspectable public var spacing: CGFloat = 10
	
	///center or full width layout
	@IBInspectable public var centered: Bool = false
	
	///available colors
	public var colors = [UIColor.red, UIColor.blue, UIColor.green]
	
	///return selected color
	public var selectedColor: UIColor?
	
	///selected color index
	public var selectedColorIndex: Int?
```


## Installation
HKColorPicker is available via CocoaPods. Add the following line to your podfile:
```ruby
pod 'HKColorPicker'
```


## Author
I'm [Hasan Kassem](https://hasankassem.com). I develop apps for iOS and Android.

Twitter: [@hasankassem_](https://twitter.com/hasankassem_) | Instagram: [@hasankassem_](https://instagram.com/hasankassem_) | Email: [hello@hasankassem.com](mailto:hello@hasankassem.com)  

## Licence

`HKColorPicker` is available under the MIT license. See the [LICENSE](LICENSE) file for more info.
