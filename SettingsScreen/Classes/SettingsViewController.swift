//
//  SettingsViewController.swift
//  SettingsScreen
//
//  Created by Prateek Sharma on 5/31/18.
//  Copyright © 2018 Prateek Sharma. All rights reserved.
//

import UIKit




class SettingsViewController: UIViewController {

    
    let tableDataSource: [TableSectionModel] = [
                        TableSectionModel(cellsData: [
                            SwitchCellModel(title: StringLiterals.airplaneMode, key: SettingKeys.airplaneMode, type: SettingType.airplaneMode, iconColor: UIColor(r: 255, g: 150, b: 0)),
                            ForwardingCellModel(title: StringLiterals.wiFi, type: SettingType.wiFi, iconColor: UIColor(r: 0, g: 118, b: 255)),
                            ForwardingCellModel(title: StringLiterals.bluetooth, type: SettingType.bluetooth, iconColor: UIColor(r: 254, g: 56, b: 36)),
                            ForwardingCellModel(title: StringLiterals.mobileData, type: SettingType.mobileData, iconColor: UIColor(r: 0, g: 118, b: 255)),
                            ForwardingCellModel(title: StringLiterals.carrier, type: SettingType.carrier, iconColor: UIColor(r: 0, g: 118, b: 255))
                            ]),
                        TableSectionModel(cellsData: [
                                ForwardingCellModel(title: StringLiterals.notifications, type: SettingType.notifications, iconColor: UIColor(r: 254, g: 56, b: 36)),
                                ForwardingCellModel(title: StringLiterals.doNotDisturb, type: SettingType.doNotDisturb, iconColor: UIColor(r: 254, g: 40, b: 81))
                            ]),
                        TableSectionModel(cellsData: [
                                ForwardingCellModel(title: StringLiterals.general, type: SettingType.general, iconColor: UIColor(r: 143, g: 142, b: 148)),
                                ForwardingCellModel(title: StringLiterals.wallpaper, type: SettingType.wallpaper, iconColor: UIColor(r: 84, g: 199, b: 252)),
                                ForwardingCellModel(title: StringLiterals.display, type: SettingType.display, iconColor: UIColor(r: 0, g: 118, b: 255))
                            ])
                        ]
    
    
    var filteredSettings = [SettingsCellModel]()
    
    
    @IBOutlet weak private var settingsTableView: UITableView! {
        didSet {
            settingsTableView.dataSource = self
            settingsTableView.delegate = self
            settingsTableView.rowHeight = UITableViewAutomaticDimension
            settingsTableView.estimatedRowHeight = 300
        }
    }
    
    let searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        return searchController
    }()
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifier.toggledSettingWindow {
            if let vc = segue.destination as? CommonSettingViewController, let settingType = sender as? SettingType {
                vc.settingType = settingType
            }
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupSearchBar()
        addSettingsUpdationListener()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    func addSettingsUpdationListener() {
        NotificationCenter.default.addObserver(forName: NSNotification.Name(StringLiterals.settingsUpdateNotification), object: nil, queue: nil) { [weak self] (notification) in
            self?.settingsTableView.reloadData()
        }
    }
    
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    func setupSearchBar() {
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    
    func filterContent(searchText: String) {
        filteredSettings.removeAll()
        tableDataSource.forEach { (sectionModel) in
            sectionModel.cellsData.forEach({ (cellModel) in
                cellModel.title.lowercased().contains(searchText.lowercased()) ? filteredSettings.append(cellModel) : ()
            })
        }
        settingsTableView.reloadData()
    }
    
}

extension SettingsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return !isFiltering ? tableDataSource.count : 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering ? filteredSettings.count : tableDataSource[section].cellsData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellData = isFiltering ? filteredSettings[indexPath.row] : tableDataSource[indexPath.section].cellsData[indexPath.row]
        if let switchCellData = cellData as? SwitchCellModel {
            return setupSwitchCell(using: switchCellData, for: indexPath)
        }
        else if let forwardingCellData = cellData as? ForwardingCellModel {
            return setupForwardingCell(using: forwardingCellData, for: indexPath)
        }
        return UITableViewCell()
    }

    func setupForwardingCell(using forwardingCellData: ForwardingCellModel, for indexPath: IndexPath) -> UITableViewCell {
        let cell = settingsTableView.dequeueReusableCell(withIdentifier: ForwardingTableViewCell.identifier, for: indexPath) as! ForwardingTableViewCell
        var subtitle: String?
        switch forwardingCellData.type {
            case SettingType.wiFi : subtitle = Settings.settings.wiFi?.name
            case SettingType.carrier : subtitle = Settings.settings.carrier?.name
            case SettingType.bluetooth : subtitle = Settings.settings.bluetooth ? "On" : "Off"
            default : subtitle = ""
        }
        cell.setup(details: forwardingCellData, subtitle: subtitle, iconColor: forwardingCellData.iconColor)
        return cell
    }

    func setupSwitchCell(using switchCellData: SwitchCellModel, for indexPath: IndexPath) -> UITableViewCell {
        let cell = settingsTableView.dequeueReusableCell(withIdentifier: SwitchTableViewCell.identifier, for: indexPath) as! SwitchTableViewCell
        cell.setup(details: switchCellData, isOn: Settings.settings.value(forKey: switchCellData.key.rawValue) as! Bool, iconColor: switchCellData.iconColor)
        return cell
    }


}

extension SettingsViewController: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellType = isFiltering ? filteredSettings[indexPath.row].type : tableDataSource[indexPath.section].cellsData[indexPath.row].type
        switch cellType {
        case .wiFi:
            present(WiFi.alertForPresenting(objects: WiFi.connections, keyToUpdate: SettingKeys.wiFi.rawValue), animated: true, completion: nil)
        case .carrier:
            present(Carrier.alertForPresenting(objects: Carrier.connections, keyToUpdate: SettingKeys.carrier.rawValue), animated: true, completion: nil)
        case .display:
            performSegue(withIdentifier: SegueIdentifier.displaySettingWindow, sender: nil)
        case .mobileData, .notifications, .bluetooth, .doNotDisturb, .general:
            performSegue(withIdentifier: SegueIdentifier.toggledSettingWindow, sender: cellType)
        default:
            print("Unknown Cell Type")
        }
    }
    
}


extension SettingsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContent(searchText: searchController.searchBar.text!)
    }
}





