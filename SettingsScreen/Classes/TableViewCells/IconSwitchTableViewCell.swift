//
//  IconSwitchTableViewCell.swift
//  SettingsScreen
//
//  Created by Prateek Sharma on 6/6/18.
//  Copyright © 2018 Prateek Sharma. All rights reserved.
//

import UIKit

class IconSwitchTableViewCell: SwitchTableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        isContentPaddingApplicable = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        isContentPaddingApplicable = false
    }
    
    
    @IBOutlet weak private var coloredView: UIView! {
        didSet {
            coloredView.layer.cornerRadius = UIConstants.coloredViewCornerRadius
            coloredView.clipsToBounds = true
        }
    }

    func setup(details: IconColoredSwitchCellViewModel, isOn: Bool) {
        coloredView?.backgroundColor = details.iconColor
        super.setup(details: details, isOn: isOn)
    }
    
}
