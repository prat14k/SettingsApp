//
//  CellModel.swift
//  SettingsScreen
//
//  Created by Prateek Sharma on 6/2/18.
//  Copyright © 2018 Prateek Sharma. All rights reserved.
//

import Foundation


protocol SettingsCellModel {
    var title: String { get }
    var key: SettingObserverKeys { get }
    var type: SettingType { get }
}


struct SwitchCellModel: SettingsCellModel{
    let title: String
    let key: SettingObserverKeys
    let type: SettingType

    init(title: String, key: SettingObserverKeys, type: SettingType) {
        self.title = title
        self.type = type
        self.key = key
    }
}


struct DisclosureCellModel: SettingsCellModel{
    let title: String
    let key: SettingObserverKeys
    let type: SettingType
    
    init(title: String, key: SettingObserverKeys, type: SettingType) {
        self.title = title
        self.type = type
        self.key = key
    }
}
