//
//  DisclosureTableViewCell.swift
//  SettingsScreen
//
//  Created by Prateek Sharma on 6/1/18.
//  Copyright © 2018 Prateek Sharma. All rights reserved.
//

import UIKit

class DisclosureTableViewCell: UITableViewCell {

    static let identifier = "disclosureCellIdentifier"
    
    @IBOutlet weak var coloredView: UIView! {
        didSet {
            coloredView.backgroundColor = UIColor.random
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
    
    
    func setup(details: DisclosureCellModel, subtitle: String?) {
        title.text = details.title
        subTitle.text = subtitle
        
    }
    
}
