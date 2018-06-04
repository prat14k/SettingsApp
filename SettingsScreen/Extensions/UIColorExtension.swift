//
//  UIColorExtension.swift
//  SettingsScreen
//
//  Created by Prateek Sharma on 6/1/18.
//  Copyright © 2018 Prateek Sharma. All rights reserved.
//

import UIKit


extension UIColor {
    
    static var random: UIColor {
        let r = CGFloat(arc4random_uniform(255)), g = CGFloat(arc4random_uniform(255)), b = CGFloat(arc4random_uniform(255))
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0)
    }
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat = 1.0) {
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: alpha)
    }
    
}
