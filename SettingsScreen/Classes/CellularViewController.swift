//
//  CellularViewController.swift
//  SettingsScreen
//
//  Created by Prateek Sharma on 6/3/18.
//  Copyright © 2018 Prateek Sharma. All rights reserved.
//

import UIKit

class CellularViewController: UIViewController {

    let tableDataSource: [SettingsCellModel] = [
        SwitchCellModel(title: StringLiterals.cellularData, key: SettingObserverKeys.mobileData, type: SettingType.mobileData),
        DisclosureCellModel(title: StringLiterals.cellularDataOptions, key: SettingObserverKeys.none, type: SettingType.none)
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension CellularViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableDataSource.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableDataSource[indexPath.row] {
        case let rowData as SwitchCellModel:
            let cell = tableView.dequeueReusableCell(withIdentifier: SwitchTableViewCell.identifier, for: indexPath) as! SwitchTableViewCell
            cell.setup(details: rowData, isOn: Settings.settings.value(forKey: rowData.key.rawValue) as! Bool)
            return cell
        case let rowData as DisclosureCellModel:
            let cell = tableView.dequeueReusableCell(withIdentifier: DisclosureTableViewCell.identifier, for: indexPath) as! DisclosureTableViewCell
            cell.setup(details: rowData, subtitle: "Roaming On")
            return cell
        default: return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return section == 0 ? StringLiterals.cellularDataSection0FooterText : nil
    }
}
