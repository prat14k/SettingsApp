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
    
    @IBOutlet weak private var settingTableView: UITableView!
    
    private var navBarTitle: String? {
        didSet {
            navigationItem.title = navBarTitle
        }
    }
    
    private var tableDataSource: [TableSectionModel]!
    
    
    private func setTableDataSource() {
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
        return tableDataSource?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableDataSource[section].cellsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rowData = tableDataSource[indexPath.section].cellsData[indexPath.row]
        switch rowData {
        case let rowData as SwitchCellViewModel:
            return setupSwitchCell(using: rowData, for: indexPath)
        case let rowData as ForwardingCellViewModel:
            return setupForwardingCell(using: rowData, for: indexPath)
        default: return UITableViewCell()
        }
    }
    
}


extension CommonSettingViewController {
    
    private func setupForwardingCell(using forwardingCellData: ForwardingCellViewModel, for indexPath: IndexPath) -> UITableViewCell {
        let cell = settingTableView.dequeueReusableCell(withIdentifier: ForwardingTableViewCell.identifier, for: indexPath) as! ForwardingTableViewCell
        switch forwardingCellData.type {
        case .mobileData: cell.setup(details: forwardingCellData, subtitle: "Roaming On")
        default: cell.setup(details: forwardingCellData, subtitle: "")
        }
        return cell
    }
    
    private func setupSwitchCell(using switchCellData: SwitchCellViewModel, for indexPath: IndexPath) -> UITableViewCell {
        let cell = settingTableView.dequeueReusableCell(withIdentifier: SwitchTableViewCell.identifier, for: indexPath) as! SwitchTableViewCell
        cell.setup(details: switchCellData, isOn: Settings.settings.value(forKey: switchCellData.key.rawValue) as! Bool)
        return cell
    }
}



extension CommonSettingViewController: UITableViewDelegate, Maskable, RoundedSection {
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return tableDataSource[section].footer
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableDataSource[section].header
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if UIScreen.isSplit {
            let roundedCorners = corners(for: indexPath.row, withTotalSectionRows: tableView.numberOfRows(inSection: indexPath.section))
            round(corners: roundedCorners, view: cell)
        }
    }
    
}




extension CommonSettingViewController {
    
    private enum TableDataSource {
        
        static let bluetoothTableDB = [
            TableSectionModel(cellsData: [SwitchCellViewModel(title: StringLiterals.bluetooth, key: SettingKeys.bluetooth, type: SettingType.bluetooth)])
        ]
        
        static let cellularDataTableDB = [
            TableSectionModel(cellsData: [
                SwitchCellViewModel(title: StringLiterals.cellularData, key: SettingKeys.mobileData, type: SettingType.mobileData),
                ForwardingCellViewModel(title: StringLiterals.cellularDataOptions, type: SettingType.mobileData)
                ], footer: StringLiterals.cellularDataHelpText)
        ]
        
        static let notificationsTableDB = [
            TableSectionModel(cellsData: [SwitchCellViewModel(title: StringLiterals.notifications, key: SettingKeys.notifications, type: SettingType.notifications)])
        ]
        
        static let doNotDisturbTableDB = [
            TableSectionModel(cellsData: [SwitchCellViewModel(title: StringLiterals.doNotDisturb, key: SettingKeys.doNotDisturb, type: SettingType.doNotDisturb)], footer: StringLiterals.doNotDisturbHelpText)
        ]
        
        static let generalSettingTableDB = [
            TableSectionModel(cellsData: [ForwardingCellViewModel(title: StringLiterals.about, type: SettingType.other),
                                          ForwardingCellViewModel(title: StringLiterals.softwareUpdate, type: SettingType.other)]),
            TableSectionModel(cellsData: [ForwardingCellViewModel(title: StringLiterals.airDrop, type: SettingType.other),
                                          ForwardingCellViewModel(title: StringLiterals.handoff, type: SettingType.other),
                                          ForwardingCellViewModel(title: StringLiterals.carPlay, type: SettingType.other)]),
            TableSectionModel(cellsData: [ForwardingCellViewModel(title: StringLiterals.accessibility, type: SettingType.other)])
        ]
        
    }
    
}


