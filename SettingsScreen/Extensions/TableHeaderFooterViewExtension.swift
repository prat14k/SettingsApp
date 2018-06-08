//
//  TableHeaderFooterViewExtension.swift
//  SettingsScreen
//
//  Created by Prateek Sharma on 6/8/18.
//  Copyright © 2018 Prateek Sharma. All rights reserved.
//

import UIKit


extension UITableViewHeaderFooterView {
    override open var frame: CGRect {
        get {
            return super.frame
        }
        set(newFrame) {
            var frame = newFrame
            if UIScreen.isSplit {
                let indent = UITableView.indent()
                frame.origin.x   += indent
                frame.size.width -= indent * 2
            }
            super.frame = frame
        }
    }
}
