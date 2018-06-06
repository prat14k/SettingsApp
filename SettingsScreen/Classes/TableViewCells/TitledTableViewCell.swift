//
//  SingleSettingTableViewCell.swift
//  SettingsScreen
//
//  Created by Prateek Sharma on 6/6/18.
//  Copyright © 2018 Prateek Sharma. All rights reserved.
//

import UIKit

class TitledTableViewCell: SettingsTableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        isContentPaddingApplicable = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        isContentPaddingApplicable = true
    }
    
    private let identifier = "titledCellIdentifier"
    
    @IBOutlet weak private var title: UILabel!
    
    func setup(details: TitledCellViewProtocol) {
        title.text = details.title
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        clipsToBounds = true
        layer.masksToBounds = true
        separatorInset = UIEdgeInsets(top: 0, left: title.frame.origin.x, bottom: 0, right: 0)
    }
    
}
