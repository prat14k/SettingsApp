//
//  SingleSettingViewController.swift
//  SettingsScreen
//
//  Created by Prateek Sharma on 6/3/18.
//  Copyright © 2018 Prateek Sharma. All rights reserved.
//

import UIKit

class CommonSettingViewController: UIViewController {
    
    var settingType: SettingType! {
        didSet {
            setTableDataSource()
        }
    }
    
    var navBarTitle: String? {
        didSet {
            navigationItem.title = navBarTitle
        }
    }
    
    var tableDataSource: [TableSectionModel]!
    
    
    func setTableDataSource() {
        switch settingType {
        case .mobileData:
            navBarTitle = StringLiterals.cellular
            tableDataSource = TableDataSource.cellularDataTableDB
        case .bluetooth:
            navBarTitle = StringLiterals.bluetooth
            tableDataSource = TableDataSource.bluetoothTableDB
        case .notifications:
            navBarTitle = StringLiterals.notifications
            tableDataSource = TableDataSource.notificationsTableDB
        case .doNotDisturb:
            navBarTitle = StringLiterals.doNotDisturb
            tableDataSource = TableDataSource.doNotDisturbTableDB
        case .general:
            navBarTitle = StringLiterals.general
            tableDataSource = TableDataSource.generalSettingTableDB
        default: print("Unknown Type")
        }
    }
    
    
}

extension CommonSettingViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableDataSource.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableDataSource[section].cellsData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rowData = tableDataSource[indexPath.section].cellsData[indexPath.row]
        switch rowData {
        case let rowData as SwitchCellModel:
            let cell = tableView.dequeueReusableCell(withIdentifier: SwitchTableViewCell.identifier, for: indexPath) as! SwitchTableViewCell
            cell.setup(details: rowData, isOn: Settings.settings.value(forKey: rowData.key.rawValue) as! Bool)
            return cell
        case let rowData as ForwardingCellModel:
            let cell = tableView.dequeueReusableCell(withIdentifier: ForwardingTableViewCell.identifier, for: indexPath) as! ForwardingTableViewCell
            switch rowData.type {
            case .mobileData: cell.setup(details: rowData, subtitle: "Roaming On")
            default: cell.setup(details: rowData, subtitle: "")
            }
            return cell
        default: return UITableViewCell()
        }
    }
 
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return tableDataSource[section].footer
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableDataSource[section].header
    }
}


extension CommonSettingViewController {
    
    private enum TableDataSource {
        
        static let bluetoothTableDB = [
            TableSectionModel(cellsData: [SwitchCellModel(title: StringLiterals.bluetooth, key: SettingKeys.bluetooth, type: SettingType.bluetooth)])
        ]
        
        static let cellularDataTableDB = [
            TableSectionModel(cellsData: [
                SwitchCellModel(title: StringLiterals.cellularData, key: SettingKeys.mobileData, type: SettingType.mobileData),
                ForwardingCellModel(title: StringLiterals.cellularDataOptions, type: SettingType.mobileData)
                ], footer: StringLiterals.cellularDataHelpText)
        ]
        
        static let notificationsTableDB = [
            TableSectionModel(cellsData: [SwitchCellModel(title: StringLiterals.notifications, key: SettingKeys.notifications, type: SettingType.notifications)])
        ]
        
        static let doNotDisturbTableDB = [
            TableSectionModel(cellsData: [SwitchCellModel(title: StringLiterals.doNotDisturb, key: SettingKeys.doNotDisturb, type: SettingType.doNotDisturb)], footer: StringLiterals.doNotDisturbHelpText)
        ]
        
        static let generalSettingTableDB = [
            TableSectionModel(cellsData: [ForwardingCellModel(title: StringLiterals.about, type: SettingType.other),
                                          ForwardingCellModel(title: StringLiterals.softwareUpdate, type: SettingType.other)]),
            TableSectionModel(cellsData: [ForwardingCellModel(title: StringLiterals.airDrop, type: SettingType.other),
                                          ForwardingCellModel(title: StringLiterals.handoff, type: SettingType.other),
                                          ForwardingCellModel(title: StringLiterals.carPlay, type: SettingType.other)]),
            TableSectionModel(cellsData: [ForwardingCellModel(title: StringLiterals.accessibility, type: SettingType.other)])
        ]
        
    }
    
}


