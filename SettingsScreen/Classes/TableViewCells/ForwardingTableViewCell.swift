//
//  ForwardingTableViewCell.swift
//  SettingsScreen
//
//  Created by Prateek Sharma on 6/1/18.
//  Copyright © 2018 Prateek Sharma. All rights reserved.
//

import UIKit

class ForwardingTableViewCell: TitledTableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        isContentPaddingApplicable = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        isContentPaddingApplicable = true
    }
    
    static let identifier = "forwardingCellIdentifier"
    
    @IBOutlet weak private var subTitle: UILabel!
    
    
    func setup(details: TitledCellViewProtocol, subtitle: String?) {
        super.setup(details: details)
        subTitle.text = subtitle
    }
    
}
