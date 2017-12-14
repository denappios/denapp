//
//  DesignableTextField.swift
//  tabbarCustom
//
//  Created by Pelorca on 09/12/2017.
//  Copyright © 2017 Eduardo Pelorca. All rights reserved.
//

import UIKit

@IBDesignable
class DesignableTextField: UITextField {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet{
            layer.cornerRadius = cornerRadius
        }
        
    }
    
    
    @IBInspectable var widthImage: CGFloat = 0 {
        didSet{
            updateView()
        }
        
    }
    
    @IBInspectable var heightImage: CGFloat = 0 {
        didSet{
            updateView()
        }
        
    }
    
    
    
    
    
    @IBInspectable var leftImage: UIImage? {
        didSet{
            updateView()
        }
        
    }
    @IBInspectable var leftPadding: CGFloat = 0 {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var rigthPadding: CGFloat = 0 {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        
        
        if let  image = leftImage {
            leftViewMode = .always
            let imageView = UIImageView(frame: CGRect(x:leftPadding, y:0, width: widthImage, height: heightImage))
            imageView.image = image
            
            var width = leftPadding + widthImage
            
            if borderStyle == UITextBorderStyle.none || borderStyle == UITextBorderStyle.line {
                width = width + rigthPadding
            }
            
            
            let view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: heightImage))
            view.addSubview(imageView)
            
            leftView = view
            
        } else {
            leftViewMode = .never
        }
        
        attributedPlaceholder = NSAttributedString(string: placeholder != nil ? placeholder! : "", attributes: [NSAttributedStringKey.foregroundColor:tintColor])
    }
    
    
    
}

@IBDesignable
class DesignableButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet{
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet{
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet{
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var shadowColor: UIColor = UIColor.clear {
        didSet{
            layer.shadowColor = shadowColor.cgColor
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 0 {
        didSet{
            layer.shadowRadius = shadowRadius
        }
    }
    
    @IBInspectable var shadowOffsetY: CGFloat = 0 {
        didSet{
            layer.shadowOffset.height = shadowOffsetY
        }
    }
    
    @IBInspectable var shadowOffsetX: CGFloat = 0 {
        didSet{
            layer.shadowOffset.width = shadowOffsetX
        }
    }
    
}

@IBDesignable public class RoundView: UIView {
    
    
    @IBInspectable var shadowColor: UIColor = UIColor.clear {
        didSet{
            layer.shadowColor = shadowColor.cgColor
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 0 {
        didSet{
            layer.shadowRadius = shadowRadius
        }
    }
    
    @IBInspectable var shadowOffsetY: CGFloat = 0 {
        didSet{
            layer.shadowOffset.height = shadowOffsetY
        }
    }
    
    @IBInspectable var shadowOffsetX: CGFloat = 0 {
        didSet{
            layer.shadowOffset.width = shadowOffsetX
        }
    }
    
    // MARK: - Properties
    
    /**
     This object's button size.
     */
    open var size: CGFloat = 56 {
        didSet {
            self.setNeedsDisplay()

        }
    }
    
    /**
     Padding from bottom right of UIScreen or superview.
     */
    open var paddingX: CGFloat = 14 {
        didSet {
            self.setNeedsDisplay()
        }
    }
    open var paddingY: CGFloat = 14 {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    
    
    /**
     Degrees to rotate image
     */
    @IBInspectable open var rotationDegrees: CGFloat = -45
    
    
    /**
     Button color.
     */
    @IBInspectable open var buttonColor: UIColor = UIColor(red: 73/255.0, green: 151/255.0, blue: 241/255.0, alpha: 1)
    
    /**
     Button image.
     */
    @IBInspectable open var buttonImage: UIImage? = nil {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    /**
     Plus icon color inside button.
     */
    @IBInspectable open var plusColor: UIColor = UIColor.black
    
    /**
     Background overlaying color.
     */
    @IBInspectable open var overlayColor: UIColor = UIColor.black.withAlphaComponent(0.3)
    
   /**
     Enable/disable shadow.
     */
    @IBInspectable open var hasShadow: Bool = true
    
    /**
     Child item's default shadow color.
     */
    @IBInspectable open var itemShadowColor: UIColor = UIColor.black
    
    /**
     
     */
    open var closed: Bool = true
    
    /**
     Whether or not floaty responds to keyboard notifications and adjusts its position accordingly
     */
    @IBInspectable open var respondsToKeyboard: Bool = true
    
  
    open var friendlyTap: Bool = true
    
    open var sticky: Bool = false
    
   
    
  
    /**
     Button shape layer.
     */
    fileprivate var circleLayer: CAShapeLayer = CAShapeLayer()
    
    /**
     Plus icon shape layer.
     */
    fileprivate var plusLayer: CAShapeLayer = CAShapeLayer()
    
    /**
     Button image view.
     */
    fileprivate var buttonImageView: UIImageView = UIImageView()
    
    /**
     If you keeping touch inside button, button overlaid with tint layer.
     */
    fileprivate var tintLayer: CAShapeLayer = CAShapeLayer()
    
    /**
     If you show items, background overlaid with overlayColor.
     */
    //    private var overlayLayer: CAShapeLayer = CAShapeLayer()
    
    fileprivate var overlayView : UIControl = UIControl()
    
    /**
     Keep track of whether overlay open animation completes, to avoid animation conflicts.
     */
    fileprivate var overlayViewDidCompleteOpenAnimation: Bool = true
    
    /**
     If you created this object from storyboard or `initWithFrame`, this property set true.
     */
    fileprivate var isCustomFrame: Bool = false
    
    // MARK: - Initialize
    
    /**
     Initialize with default property.
     */
    public init() {
        super.init(frame: CGRect(x: 0, y: 0, width: size, height: size))
        backgroundColor = UIColor.clear
 }
    
    /**
     Initialize with custom size.
     */
    public init(size: CGFloat) {
        self.size = size
        super.init(frame: CGRect(x: 0, y: 0, width: size, height: size))
        backgroundColor = UIColor.clear
   }
    
    /**
     Initialize with custom frame.
     */
    public override init(frame: CGRect) {
        super.init(frame: frame)
        size = min(frame.size.width, frame.size.height)
        backgroundColor = UIColor.clear
        isCustomFrame = true
    }
    
    /**
     Initialize from storyboard.
     */
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        size = min(frame.size.width, frame.size.height)
        backgroundColor = UIColor.clear
        clipsToBounds = false
        isCustomFrame = true
       
    }
    
    // MARK: - Method
    
    /**
     Set size and frame.
     */
    open override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
        if isCustomFrame == false {
            
        } else {
            size = min(frame.size.width, frame.size.height)
        }
        
        setCircleLayer()
        if buttonImage == nil {
            setPlusLayer()
        } else {
            setButtonImage()
        }
        setShadow()
    }
    

    

    

   
    

    
    fileprivate func setCircleLayer() {
        circleLayer.removeFromSuperlayer()
        circleLayer.frame = CGRect(x: 0, y: 0, width: size, height: size)
        circleLayer.backgroundColor = buttonColor.cgColor
        circleLayer.cornerRadius = size/2
        layer.addSublayer(circleLayer)
    }
    
    fileprivate func setPlusLayer() {
        plusLayer.removeFromSuperlayer()
        plusLayer.frame = CGRect(x: 0, y: 0, width: size, height: size)
        plusLayer.lineCap = kCALineCapRound
        plusLayer.strokeColor = plusColor.cgColor
        plusLayer.lineWidth = 2.0
        plusLayer.path = plusBezierPath().cgPath
        layer.addSublayer(plusLayer)
    }
    
    fileprivate func setButtonImage() {
        buttonImageView.removeFromSuperview()
        buttonImageView = UIImageView(image: buttonImage)
        buttonImageView.tintColor = plusColor
        buttonImageView.frame = CGRect(
            x: circleLayer.frame.origin.x + (size / 2 - buttonImageView.frame.size.width / 2),
            y: circleLayer.frame.origin.y + (size / 2 - buttonImageView.frame.size.height / 2),
            width: buttonImageView.frame.size.width,
            height: buttonImageView.frame.size.height
        )
        
        addSubview(buttonImageView)
    }
    
    fileprivate func setTintLayer() {
        tintLayer.frame = CGRect(x: circleLayer.frame.origin.x, y: circleLayer.frame.origin.y, width: size, height: size)
        tintLayer.backgroundColor = UIColor.white.withAlphaComponent(0.2).cgColor
        tintLayer.cornerRadius = size/2
        layer.addSublayer(tintLayer)
    }
    
    fileprivate func setOverlayView() {
        setOverlayFrame()
        overlayView.backgroundColor = overlayColor
        overlayView.alpha = 0
        overlayView.isUserInteractionEnabled = true
        
    }
    fileprivate func setOverlayFrame() {
        if let superview = superview {
            overlayView.frame = CGRect(
                x: 0,y: 0,
                width: superview.bounds.width,
                height: superview.bounds.height
            )
        }
    }
    
    fileprivate func setShadow() {
        if !hasShadow {
            return
        }
        
        circleLayer.shadowOffset = CGSize(width: 1, height: 1)
        circleLayer.shadowRadius = 2
        circleLayer.shadowColor = UIColor.black.cgColor
        circleLayer.shadowOpacity = 0.4
    }
    
    fileprivate func plusBezierPath() -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: size/2, y: size/3))
        path.addLine(to: CGPoint(x: size/2, y: size-size/3))
        path.move(to: CGPoint(x: size/3, y: size/2))
        path.addLine(to: CGPoint(x: size-size/3, y: size/2))
        return path
    }
    
  
    
  open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if isTouched(touches) {
            setTintLayer()
        }
    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        tintLayer.removeFromSuperlayer()
        if isTouched(touches) {
      }
    }
    
    fileprivate func isTouched(_ touches: Set<UITouch>) -> Bool {
        return touches.count == 1 && touches.first?.tapCount == 1 && touches.first?.location(in: self) != nil
    }

}




