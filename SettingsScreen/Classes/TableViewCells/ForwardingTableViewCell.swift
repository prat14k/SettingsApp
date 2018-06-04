//
//  ForwardingTableViewCell.swift
//  SettingsScreen
//
//  Created by Prateek Sharma on 6/1/18.
//  Copyright © 2018 Prateek Sharma. All rights reserved.
//

import UIKit

class ForwardingTableViewCell: UITableViewCell {

    static let identifier = "forwardingCellIdentifier"
    
    @IBOutlet weak var coloredView: UIView! {
        didSet {
            coloredView.layer.cornerRadius = 7
            coloredView.clipsToBounds = true
        }
    }
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutMargins = UIEdgeInsets.zero
        separatorInset = UIEdgeInsets(top: 0, left: title.frame.origin.x, bottom: 0, right: 0)
    }
    
    func setup(details: ForwardingCellModel, subtitle: String?, iconColor: UIColor? = nil) {
        coloredView?.backgroundColor = iconColor
        
        title.text = details.title
        subTitle.text = subtitle
    }
    
}
