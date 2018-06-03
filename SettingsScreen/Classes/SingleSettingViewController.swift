//
//  SingleSettingViewController.swift
//  SettingsScreen
//
//  Created by Prateek Sharma on 6/3/18.
//  Copyright © 2018 Prateek Sharma. All rights reserved.
//

import UIKit

class SingleSettingViewController: UIViewController {

    var navBarTitle: String? {
        didSet {
            navigationItem.title = navBarTitle
        }
    }
    
    var tableDataSource: [TableSectionModel]!
    
}

extension SingleSettingViewController: UITableViewDataSource {
    
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
        case let rowData as DisclosureCellModel:
            let cell = tableView.dequeueReusableCell(withIdentifier: DisclosureTableViewCell.identifier, for: indexPath) as! DisclosureTableViewCell
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
