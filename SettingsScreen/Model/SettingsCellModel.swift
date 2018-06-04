//
//  CellModel.swift
//  SettingsScreen
//
//  Created by Prateek Sharma on 6/2/18.
//  Copyright © 2018 Prateek Sharma. All rights reserved.
//

import UIKit


struct TableSectionModel {
    var header: String?
    var footer: String?
    var cellsData: [SettingsCellModel]
    
    init(cellsData: [SettingsCellModel], header: String? = nil, footer: String? = nil) {
        self.cellsData = cellsData
        self.header = header
        self.footer = footer
    }
}


protocol SettingsCellModel {
    var title: String { get }
    var type: SettingType { get }
    var iconColor: UIColor? { get }
}


struct SwitchCellModel: SettingsCellModel{
    
    let title: String
    let key: SettingKeys
    let type: SettingType
    let iconColor: UIColor?
    
    init(title: String, key: SettingKeys, type: SettingType, iconColor: UIColor? = nil) {
        self.title = title
        self.type = type
        self.key = key
        self.iconColor = iconColor
    }
}


struct ForwardingCellModel: SettingsCellModel{
    let title: String
    let type: SettingType
    let iconColor: UIColor?
    
    init(title: String, type: SettingType, iconColor: UIColor? = nil) {
        self.title = title
        self.type = type
        self.iconColor = iconColor
    }
}
