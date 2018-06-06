//
//  SettingsTableViewCell.swift
//  SettingsScreen
//
//  Created by Prateek Sharma on 6/6/18.
//  Copyright © 2018 Prateek Sharma. All rights reserved.
//

import UIKit


class SettingsTableViewCell: UITableViewCell {
    
    var isContentPaddingApplicable = false
    
    override var frame: CGRect {
        get {
            return super.frame
        }
        set(newFrame) {
            var frame = newFrame
            if isContentPaddingApplicable && UIScreen.isSplit {
                let indent = UITableView.indent()
                frame.origin.x   += indent
                frame.size.width -= indent * 2
            }
            layer.mask = nil
            super.frame = frame
        }
    }
    
}
