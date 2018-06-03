//
//  CellModel.swift
//  SettingsScreen
//
//  Created by Prateek Sharma on 6/2/18.
//  Copyright © 2018 Prateek Sharma. All rights reserved.
//

import Foundation


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
    let type: SettingType
    
    
    init(title: String, type: SettingType) {
        self.title = title
        self.type = type
    }
}
