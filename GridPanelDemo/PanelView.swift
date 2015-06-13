//
//  PanelView.swift
//  GridPanelDemo
//
//  Created by jason on 6/21/14.
//  Copyright (c) 2014 jason. All rights reserved.
//

class PanelView:UIView {
    
    var frontSubviews:Array<AnyObject>!
    var frontViewConstraints:Array<AnyObject>!
    var frontViewBackgroundColor:UIColor!
    
    var backViewBackgroundColor:UIColor!
    var backViewTitle:String!
    
    var isFrontView:Bool = true
    
    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    init(bgColor:UIColor) {
        super.init(frame: CGRectMake(0, 0, 0, 0))
        self.backgroundColor          = bgColor
        self.frontViewBackgroundColor = bgColor
        self.setTranslatesAutoresizingMaskIntoConstraints(false)
    }
    
    func changeToFrontView() {
        
        self.removeAllSubviewsAndConstraints()
        for view :AnyObject in self.frontSubviews {
            self.addSubview(view as! UIView)
        }
        self.addConstraints(frontViewConstraints)
        self.backgroundColor = frontViewBackgroundColor
        
    }
    
    func changeToBackView() {
        
        self.removeAllSubviewsAndConstraints()
        self.labelWithTitle(self.backViewTitle, inPanelView: self)
        self.backgroundColor = self.backViewBackgroundColor
        
    }
    
    func removeAllSubviewsAndConstraints() {
        
        for view : AnyObject in self.subviews {
            view.removeFromSuperview()
        }
        self.removeConstraints(self.frontViewConstraints)
    }
    
    func changeView() {
        
        if self.isFrontView {
            
            self.frontSubviews = self.subviews
            self.frontViewConstraints = self.constraints()
            self.isFrontView = false
            self.changeToBackView()
            
        } else {
            
            self.isFrontView = true
            self.changeToFrontView()
            
        }
    
    }
    
    func labelWithTitle(title:String,inPanelView:UIView) {
        
        var label:UILabel   = UILabel()
        label.textColor     = UIColor.whiteColor()
        label.text          = title
        label.font          = UIFont.systemFontOfSize(17)
        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        label.numberOfLines = 0
        
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        inPanelView.addSubview(label)
        inPanelView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-35-[label]-35-|",
            options: NSLayoutFormatOptions.AlignAllBaseline,
            metrics: nil,
            views:["label":label]
        ))
        inPanelView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-40-[label]-40-|",
            options: NSLayoutFormatOptions.AlignAllBaseline,
            metrics: nil,
            views: ["label":label]))
    }
    
}