//
//  SwitchTableViewCell.swift
//  SettingsScreen
//
//  Created by Prateek Sharma on 6/1/18.
//  Copyright © 2018 Prateek Sharma. All rights reserved.
//

import UIKit

class SwitchTableViewCell: UITableViewCell {

    static let identifier = "switchCellIdentifier"
    
    @IBOutlet weak var coloredView: UIView! {
        didSet {
            coloredView.backgroundColor = UIColor.random
            coloredView.layer.cornerRadius = 7
            coloredView.clipsToBounds = true
        }
    }
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var toggleSwitch: UISwitch!
    
    
    func setup(details: [String: Any]) {
        title.text = details["title"] as? String
        toggleSwitch.isOn = details["state"] as! Bool
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutMargins = UIEdgeInsets.zero
        separatorInset = UIEdgeInsets(top: 0, left: title.frame.origin.x, bottom: 0, right: 0)
    }
    
    
    @IBAction func valueChanged(_ sender: UISwitch) {
        print(sender.isOn)
    }
    
}
