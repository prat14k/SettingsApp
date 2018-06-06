//
//  SwitchTableViewCell.swift
//  SettingsScreen
//
//  Created by Prateek Sharma on 6/1/18.
//  Copyright © 2018 Prateek Sharma. All rights reserved.
//

import UIKit


class SwitchTableViewCell: TitledTableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        isContentPaddingApplicable = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        isContentPaddingApplicable = true
    }
    
    static let identifier = "switchCellIdentifier"
    
    private var settingKey: SettingKeys!
    @IBOutlet weak private var toggleSwitch: UISwitch!
    
    
    func setup(details: (TitledCellViewProtocol & KeyDefinedCellViewProtocol), isOn: Bool) {
        settingKey = details.key
        toggleSwitch.isOn = isOn
        super.setup(details: details)
    }
    
    @IBAction private func valueChanged(_ sender: UISwitch) {
        do {
            try RealmService.shared.update(object: Settings.settings, with: [settingKey.rawValue: sender.isOn])
            NotificationCenter.default.post(name: NSNotification.Name(StringLiterals.settingsUpdateNotification), object: nil)
        } catch {
            print(error)
        }
    }
    
}













