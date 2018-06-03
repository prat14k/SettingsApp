//
//  DataSources.swift
//  SettingsScreen
//
//  Created by Prateek Sharma on 6/3/18.
//  Copyright © 2018 Prateek Sharma. All rights reserved.
//

import UIKit


enum DataSource {
    
    static let bluetoothTableDB = [
        TableSectionModel(cellsData: [SwitchCellModel(title: StringLiterals.bluetooth, key: SettingObserverKeys.bluetooth, type: SettingType.bluetooth)])
    ]
    
    static let cellularDataTableDB = [
        TableSectionModel(cellsData: [SwitchCellModel(title: StringLiterals.cellularData, key: SettingObserverKeys.mobileData, type: SettingType.mobileData),
                                      DisclosureCellModel(title: StringLiterals.cellularDataOptions, type: SettingType.mobileData)
                                    ], footer: StringLiterals.cellularDataHelpText)
    ]
    
    static let notificationsTableDB = [
        TableSectionModel(cellsData: [SwitchCellModel(title: StringLiterals.notifications, key: SettingObserverKeys.notifications, type: SettingType.notifications)])
    ]
    
    static let doNotDisturbTableDB = [
        TableSectionModel(cellsData: [SwitchCellModel(title: StringLiterals.doNotDisturb, key: SettingObserverKeys.doNotDisturb, type: SettingType.doNotDisturb)], footer: StringLiterals.doNotDisturbHelpText)
    ]

}