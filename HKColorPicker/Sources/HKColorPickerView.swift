//
//  HKColorPickerView.swift
//  HKColorPicker
//
//  Created by Hasan Kassem on 8/14/20.
//  Copyright © 2020 Hasan Kassem. All rights reserved.
//

import UIKit

@IBDesignable
open class HKColorPickerView: UIControl{
    ///number of buttons, only for storyboard
    @IBInspectable public var number: Int = 6{
        didSet{
            self.subviews.forEach({ $0.removeFromSuperview() })
            number = number <= 1 ? 2 : number
            commonInit()
        }
    }
    
    ///spacing between buttons if centered
    @IBInspectable public var spacing: CGFloat = 10 {
        didSet{
            layoutSubviews()
        }
    }
    ///center or full width layout
    @IBInspectable public var centered: Bool = false {
        didSet{
            layoutSubviews()
        }
    }
    ///available colors
    public var colors = [UIColor.red, UIColor.blue, UIColor.green] {
        didSet{
            number = colors.count
            commonInit()
            self.subviews.forEach({ if let colorButton = $0 as? HKColorButton {colorButton.color = colors[colorButton.tag%colors.count]} })
        }
    }
    ///return selected color
    public var selectedColor: UIColor?{
        return selectedColorIndex == nil ? nil : colors[selectedColorIndex!]
    }
    ///selected color index
    public var selectedColorIndex: Int?{
        didSet{
            //update buttons states
            self.subviews.forEach({ if let colorButton = $0 as? HKColorButton {colorButton.isOn = colorButton.tag == selectedColorIndex} })
            //send actions
            sendActions(for: .valueChanged)
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    //create buttons, assign tags, colors, target
    private func commonInit() {
        for i in 0..<number{
            let b1 = HKColorButton()
            b1.color = colors[i%colors.count]
            b1.tag = i
            b1.addTarget(self, action: #selector(update), for: .touchUpInside)
            self.insertSubview(b1, at: 0)
        }
    }
    //calculate & update frames for buttons
    open override func layoutSubviews() {
        super.layoutSubviews()
        //dimentions of each button
        let dim = min((self.bounds.width - spacing * CGFloat(number-1) )/CGFloat(number), self.bounds.height)
        //space before all buttons (to center)
        let pre = centered ? (self.bounds.width - CGFloat(number)*dim - spacing*CGFloat(number-1))/2 : 0
        //space between buttons
        let space = centered ? spacing : (self.bounds.width - CGFloat(number)*dim)/CGFloat(number-1)
        //update frames for buttons
        self.subviews.forEach({ $0.frame = CGRect(x: pre+CGFloat($0.tag)*(dim+space), y: (self.bounds.height-dim)/2, width: dim, height: dim)})
    }
    //on color selected
    @objc func update(_ sender: HKColorButton){
        //update buttons states
        self.subviews.forEach({ if let colorButton = $0 as? HKColorButton {colorButton.isOn = colorButton.tag == sender.tag} })
        //update selected color index
        selectedColorIndex = sender.tag
        //send actions
        sendActions(for: .valueChanged)
    }
}

internal class HKColorButton: UIButton{
    //whether a button is selected or not
    var isOn: Bool = false{
        didSet{
            //show/hide ring
            ring.isHidden = !isOn
        }
    }
    //button's color
    var color: UIColor! = .red{
        didSet{
            layoutSubviews()
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    //setup button and add target
    func setUp(){
        self.clipsToBounds = true
        addTarget(self, action: #selector(clicked), for: .touchUpInside)
        if #available(iOS 13.4, *){
            isPointerInteractionEnabled = true
        }
    }
    //update state when clicked
    @objc func clicked(_ sender: UIButton?){
        isOn = !isOn
    }
    //draw button, filled circle and a surrouding ring
    var ring: CAShapeLayer!
    var fill: CAShapeLayer!
    override func draw(_ rect: CGRect) {
        if ring == nil{
            let radius = min(rect.width/2, rect.height/2)
            let circlePath = UIBezierPath(ovalIn: CGRect(x: 2, y: 2, width: radius*2 - 4, height: radius*2 - 4))
            ring = CAShapeLayer()
            ring.path = circlePath.cgPath
            ring.fillColor = UIColor.clear.cgColor
            ring.strokeColor = color.cgColor
            ring.lineWidth = 2.0
            ring.position = CGPoint(
                x: bounds.midX - radius,
                y: bounds.midY - radius
            )
            layer.addSublayer(ring)
            ring.isHidden = !isOn
        }
        if fill == nil{
            let radius = min(rect.width/2, rect.height/2)
            let circlePath = UIBezierPath(ovalIn: CGRect(x: 5, y: 5, width: radius*2 - 10, height: radius*2 - 10))
            fill = CAShapeLayer()
            fill.path = circlePath.cgPath
            fill.fillColor = color.cgColor
            fill.strokeColor = UIColor.clear.cgColor
            fill.lineWidth = 2.0
            fill.position = CGPoint(
                x: bounds.midX - radius,
                y: bounds.midY - radius
            )
            layer.addSublayer(fill)
        }
    }
}
