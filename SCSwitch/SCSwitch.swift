//
//  SCSwitch.swift
//  SCSwitch
//
//  Created by Sagar Chauhan on 26/03/2020.
//  Copyright © 2020 Sagar Chauhan. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable public class SCSwitch: UIControl {
    
    //---------------------------------------------------------------------------
    // MARK:- Variables
    //---------------------------------------------------------------------------
    
    /// To display on state of switch
    private var onState             : UIView?
    
    /// To display off state of switch
    private var offState            : UIView?
    
    /// To display image instead of view inside switch
    private var thumbImageView      : UIImageView?
    
    // To display thumb view
    private var thumbView           : UIView?
    
    /// To display text inside thumbView
    private var thumbLabel          : UILabel?
    
    /// To check switch on or off
    private var on                  : Bool = false
    
    /// Check control is moved.
    /// When switch move to left or right, this variable will true or false
    private var bMoved              : Bool = false
    
    /// Maintain previous state of switch
    private var prevState           : Bool = false
    
    
    // On / Off state colors
    @IBInspectable public var onColor : UIColor = .green {
        didSet {
            self.onState?.backgroundColor = onColor
            self.prepareForInterfaceBuilder()
        }
    }
    
    @IBInspectable public var offColor : UIColor = .black {
        didSet {
            self.offState?.backgroundColor = offColor
            self.prepareForInterfaceBuilder()
        }
    }
    
    @IBInspectable public var isOn : Bool {
        get {
            return self.thumbImageView!.frame.origin.x != 0
        }
        set {
            self.on = newValue
            self.setOn(self.on)
        }
    }
    
    
    //--------------------------------------------------
    // MARK:- Init Methods
    //--------------------------------------------------
    
    /// Default init method calling setupView() method to create switch view
    init() {
        super.init(frame: .zero)
        self.setupView()
    }
    
    //--------------------------------------------------
    
    /// Required init method calling setupView() method to create switch view
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()
    }
    
    //--------------------------------------------------
    
    /// Frame init method calling setupView() method to create switch view
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    
    //--------------------------------------------------
    // MARK:- Custom Methods
    //--------------------------------------------------
    
    /// This method will initilise all required view and setup their required propeties.
    private func setupView() {
        
        self.clipsToBounds = true
        self.backgroundColor = .clear
        
        // Initilise onState View
        if self.onState == nil {
             self.onState = UIView(frame: CGRect(x: 0, y: (self.frame.height / 2) - 10, width: self.frame.width, height: 20))
        }
        self.onState?.backgroundColor = self.onColor
        self.onState?.layer.cornerRadius = 10
        self.onState?.clipsToBounds = true
        
        // Initilise offState View
        if self.offState == nil {
            self.offState = UIView(frame: CGRect(x: self.frame.width, y: (self.frame.height / 2) - 10, width: self.frame.width, height: 20))
        }
        self.offState?.backgroundColor = self.offColor
        self.offState?.layer.cornerRadius = 10
        self.offState?.clipsToBounds = true
        
        // Initilise thumbView View
        if self.thumbView == nil {
            self.thumbView = UIView(frame: CGRect(x: self.onState!.frame.width - self.frame.height, y: 0, width: self.frame.height - 10, height: self.frame.height - 10))
        }
        self.thumbView?.backgroundColor = .red
        self.thumbView?.layer.borderColor = UIColor.lightGray.cgColor
        self.thumbView?.layer.borderWidth = 3.0
        self.thumbView?.layer.cornerRadius = self.thumbView!.frame.height / 2
        self.thumbView?.setShadowWithCornerRadius()
        
        // Initilise thumbLabel View
        if self.thumbLabel == nil {
            self.thumbLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.thumbView!.frame.width, height: self.thumbView!.frame.height))
        }
        self.thumbLabel?.font = UIFont.systemFont(ofSize: 14)
        self.thumbLabel?.backgroundColor = .clear
        self.thumbLabel?.numberOfLines = 0
        self.thumbLabel?.text = "Reject"
        self.thumbLabel?.textColor = .white
        self.thumbLabel?.textAlignment = .center
        
        // Initilise thumbImageView View
        if self.thumbImageView == nil {
            self.thumbImageView = UIImageView(frame: CGRect(x: self.onState!.frame.width - self.frame.height, y: 0, width: self.frame.height, height: self.frame.height))
        }
        self.thumbImageView?.backgroundColor = .black
        //        self.thumbImageView?.layer.borderColor = UIColor.white.cgColor
        //        self.thumbImageView?.layer.borderWidth = 2.0
        self.thumbImageView?.layer.cornerRadius = self.thumbImageView!.frame.height / 2
        
        // Add offState view
        if !self.subviews.contains(self.offState!) {
            self.addSubview(self.offState!)
        }
        
        // Add onState view
        if !self.subviews.contains(self.onState!) {
            self.addSubview(self.onState!)
        }
        
        // Add thumbView
        if !self.subviews.contains(self.thumbView!) {
            self.addSubview(self.thumbView!)
        }
        
        // Add label
        if !self.thumbView!.contains(self.thumbLabel!) {
            self.thumbView?.addSubview(self.thumbLabel!)
        }
    }
    
    //---------------------------------------------------------------------------
    
    /// Use this method to change state of switch to on/off
    public func setOn(_ on: Bool) {
        self.setOn(on, animated: false)
    }
    
    //--------------------------------------------------
    
    /// Use method to set thumbnail image
    public func setHandleImage(_ image: UIImage) {
        self.thumbImageView?.backgroundColor  = .clear
        self.thumbImageView?.layer.borderColor = UIColor.clear.cgColor
        self.thumbImageView?.layer.borderWidth = 0
        self.thumbImageView?.layer.cornerRadius = 0
        self.thumbImageView?.image = image
    }
    
    //--------------------------------------------------
    
    // This method will animate view and change state from on to off and vice-versa.
    private func setOn(_ on: Bool, animated: Bool) {
        
        UIView.animate(withDuration: animated ? 0.1 : 0.0, delay: 0.0, options: .curveEaseInOut, animations: {
            
            if on {
                
                self.onState?.frame = CGRect(x: 0, y: (self.frame.height / 2) - 10, width: self.onState!.frame.width, height: 20)
                
                self.offState?.frame = CGRect(x: self.onState!.frame.width, y: (self.frame.height / 2) - 10, width: self.offState!.frame.width, height: 20)
                
                self.thumbImageView?.center = CGPoint(x: (self.onState!.frame.origin.x + self.onState!.frame.size.width) - self.thumbImageView!.frame.width / 2, y: self.center.y / 2 + 20)
                
                self.thumbView?.center = CGPoint(x: (self.onState!.frame.origin.x + self.onState!.frame.size.width) - self.thumbView!.frame.width / 2, y: self.onState!.center.y)
                
            } else {
                
                self.onState?.frame = CGRect(x: -self.onState!.frame.width, y: (self.frame.height / 2) - 10, width: self.onState!.frame.width, height: 20)
                
                self.offState?.frame = CGRect(x: 0, y: (self.frame.height / 2) - 10, width: self.offState!.frame.width, height: 20)
                
                self.thumbImageView?.center = CGPoint(x: (self.onState!.frame.origin.x + self.onState!.frame.size.width) + self.thumbImageView!.frame.width / 2, y: self.center.y / 2 + 20)
                
                self.thumbView?.center = CGPoint(x: (self.onState!.frame.origin.x + self.onState!.frame.size.width) + self.thumbView!.frame.width / 2, y: self.onState!.center.y)
            }
            
        }, completion: nil)
    }
    
    
    //---------------------------------------------------------------------------
    // MARK:-
    // MARK:- Gesture Methods
    //---------------------------------------------------------------------------
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // save previous value to prevent sending actions when value wasn't changed.
        prevState = self.isOn
    }
    
    //--------------------------------------------------
    
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        bMoved = true
        
        guard let point = event?.allTouches?.first?.location(in: self) else { return }
        
        if point.x > self.frame.height / 2, point.x < self.frame.width - (self.frame.height / 2) {
            
            self.onState?.frame = CGRect(x: point.x - self.onState!.frame.size.width, y: (self.frame.height / 2) - 10, width: self.onState!.frame.width, height: 20)
            
            self.offState?.frame = CGRect(x: self.onState!.frame.origin.x + self.onState!.frame.size.width, y: (self.frame.height / 2) - 10, width: self.onState!.frame.width, height: 20)
            
            self.thumbImageView?.center = CGPoint(x: self.onState!.frame.origin.x + self.onState!.frame.size.width, y: self.center.y / 2 + 20)
            
            self.thumbView?.center = CGPoint(x: self.onState!.frame.origin.x + self.onState!.frame.size.width, y: self.onState!.center.y)
        }
    }
    
    //--------------------------------------------------
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if bMoved {
            bMoved = false
            self.setOn((self.onState!.frame.origin.x + self.onState!.frame.width > self.frame.width / 2), animated: true)
        } else {
            self.setOn(!self.isOn, animated: true)
        }
        
        if prevState == self.isOn {
            return
        }
        
        self.sendActions(for: [.touchUpInside, .touchUpOutside])
    }
}

extension SCSwitch {
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setupView()
        self.setOn(self.on)
    }
}


//---------------------------------------------------------------------------
// MARK:-
// MARK:- Extension - UIView
//---------------------------------------------------------------------------

extension UIView {
    
    /// Code to set corner radius and shadow simulataneously on view
    /// i.e. Currently only for header view (custom navigation view) with theme color
    fileprivate func setShadowWithCornerRadius() {
        
        // Remove previously added layer
        self.layer.sublayers?.forEach({ $0.removeFromSuperlayer() })
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.allCorners], cornerRadii: CGSize(width: self.bounds.height / 2, height: self.bounds.height / 2)).cgPath
        shapeLayer.fillColor = UIColor.blue.cgColor
        shapeLayer.masksToBounds = false
        
        shapeLayer.shadowColor = UIColor.darkGray.cgColor
        shapeLayer.shadowPath = shapeLayer.path
        shapeLayer.shadowOffset = CGSize(width: 0, height: 3)
        shapeLayer.shadowOpacity = 0.4
        shapeLayer.shadowRadius = 2.0
        
        self.layer.insertSublayer(shapeLayer, at: 0)
    }
}
