//
//  BluetoothViewController.swift
//  SettingsScreen
//
//  Created by Prateek Sharma on 6/3/18.
//  Copyright © 2018 Prateek Sharma. All rights reserved.
//

import UIKit

class BluetoothViewController: UIViewController {

    let tableDataSource: [SettingsCellModel] = [
        SwitchCellModel(title: StringLiterals.bluetooth, key: SettingObserverKeys.bluetooth, type: SettingType.bluetooth)
    ]
    
}

extension BluetoothViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableDataSource.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SwitchTableViewCell.identifier, for: indexPath) as! SwitchTableViewCell
        guard let rowData = tableDataSource[indexPath.row] as? SwitchCellModel else { return cell }
        cell.setup(details: rowData, isOn: Settings.settings.value(forKey: rowData.key.rawValue) as! Bool)
        return cell
    }
    
}
