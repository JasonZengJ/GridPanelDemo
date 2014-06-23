//
//  UIColor+Extension.swift
//  GridPanelDemo
//
//  Created by jason on 6/19/14.
//  Copyright (c) 2014 jason. All rights reserved.
//

extension UIColor {
    
   convenience init(hex:uint,alpha:CGFloat) {
    
        let blue  = CGFloat(hex & 0x0000FF)
        let green = CGFloat((hex & 0x00FF00) >> 8)
        let red   = CGFloat((hex & 0xFF0000) >> 16)
    
        self.init(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha)
    
    }
    
}