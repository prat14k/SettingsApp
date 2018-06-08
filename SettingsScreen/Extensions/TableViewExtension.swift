//
//  TableViewExtension.swift
//  SettingsScreen
//
//  Created by Prateek Sharma on 6/8/18.
//  Copyright © 2018 Prateek Sharma. All rights reserved.
//

import UIKit


extension UITableView {
    
    static let indentByDeviceOrientation: (portrait: CGFloat, landscape: CGFloat) = {
        return UIDevice.isIPad ? (portrait: 20, landscape: 90) : (portrait: 0, landscape: 10)
    }()
    
    class func indent(isLandscape: Bool = UIDevice.isLandscape) -> CGFloat {
        return isLandscape ? indentByDeviceOrientation.landscape : indentByDeviceOrientation.portrait
    }
    
}
