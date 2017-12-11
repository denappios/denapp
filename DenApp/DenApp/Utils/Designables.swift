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



