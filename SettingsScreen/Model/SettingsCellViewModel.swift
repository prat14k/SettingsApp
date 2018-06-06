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
    var cellsData: [TitledCellViewProtocol & TypeCellViewProtocol]
    
    init(cellsData: [TitledCellViewProtocol & TypeCellViewProtocol], header: String? = nil, footer: String? = nil) {
        self.cellsData = cellsData
        self.header = header
        self.footer = footer
    }
}



protocol CellViewProtocol { }
protocol TitledCellViewProtocol: CellViewProtocol {
    var title: String { get }
}
protocol TypeCellViewProtocol: CellViewProtocol {
    var type: SettingType { get }
}
protocol KeyDefinedCellViewProtocol: CellViewProtocol {
    var key: SettingKeys { get }
}
protocol IconColorCellViewProtocol: CellViewProtocol {
    var iconColor: UIColor? { get }
}


struct SwitchCellViewModel: TitledCellViewProtocol, KeyDefinedCellViewProtocol, TypeCellViewProtocol {
    let title: String
    let key: SettingKeys
    let type: SettingType

    init(title: String, key: SettingKeys, type: SettingType) {
        self.title = title
        self.type = type
        self.key = key
    }
}

struct IconColoredSwitchCellViewModel: TitledCellViewProtocol, KeyDefinedCellViewProtocol, TypeCellViewProtocol, IconColorCellViewProtocol {
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


struct ForwardingCellViewModel: TitledCellViewProtocol, TypeCellViewProtocol {
    let title: String
    let type: SettingType

    init(title: String, type: SettingType) {
        self.title = title
        self.type = type
    }
}

struct IconColoredForwardingCellViewModel: TitledCellViewProtocol, TypeCellViewProtocol, IconColorCellViewProtocol {
    let title: String
    let type: SettingType
    let iconColor: UIColor?
    
    init(title: String, type: SettingType, iconColor: UIColor? = nil) {
        self.title = title
        self.type = type
        self.iconColor = iconColor
    }
}

