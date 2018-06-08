//
//  SettingsViewController.swift
//  SettingsScreen
//
//  Created by Prateek Sharma on 5/31/18.
//  Copyright © 2018 Prateek Sharma. All rights reserved.
//

import UIKit




class SettingsViewController: UIViewController {

    
    private let tableDataSource: [TableSectionModel] = [
                        TableSectionModel(cellsData: [
                            IconColoredSwitchCellViewModel(title: StringLiterals.airplaneMode, type: SettingTypeKeys.airplaneMode, iconColor: UIColor(r: 255, g: 150, b: 0)),
                            IconColoredForwardingCellViewModel(title: StringLiterals.wiFi, type: SettingTypeKeys.wiFi, iconColor: UIColor(r: 0, g: 118, b: 255)),
                            IconColoredForwardingCellViewModel(title: StringLiterals.bluetooth, type: SettingTypeKeys.bluetooth, iconColor: UIColor(r: 254, g: 56, b: 36)),
                            IconColoredForwardingCellViewModel(title: StringLiterals.mobileData, type: SettingTypeKeys.mobileData, iconColor: UIColor(r: 0, g: 118, b: 255)),
                            IconColoredForwardingCellViewModel(title: StringLiterals.carrier, type: SettingTypeKeys.carrier, iconColor: UIColor(r: 0, g: 118, b: 255))
                            ]),
                        TableSectionModel(cellsData: [
                                IconColoredForwardingCellViewModel(title: StringLiterals.notifications, type: SettingTypeKeys.notifications, iconColor: UIColor(r: 254, g: 56, b: 36)),
                                IconColoredForwardingCellViewModel(title: StringLiterals.doNotDisturb, type: SettingTypeKeys.doNotDisturb, iconColor: UIColor(r: 254, g: 40, b: 81))
                            ]),
                        TableSectionModel(cellsData: [
                                IconColoredForwardingCellViewModel(title: StringLiterals.general, type: SettingTypeKeys.general, iconColor: UIColor(r: 143, g: 142, b: 148)),
                                IconColoredForwardingCellViewModel(title: StringLiterals.wallpaper, type: SettingTypeKeys.wallpaper, iconColor: UIColor(r: 84, g: 199, b: 252)),
                                IconColoredForwardingCellViewModel(title: StringLiterals.display, type: SettingTypeKeys.display, iconColor: UIColor(r: 0, g: 118, b: 255))
                            ])
                        ]
    
    
    private var filteredSettings = [TitledCellViewProtocol & TypeCellViewProtocol]()
    
    
    @IBOutlet weak private var settingsTableView: UITableView! {
        didSet {
            settingsTableView.dataSource = self
            settingsTableView.delegate = self
            settingsTableView.rowHeight = UITableViewAutomaticDimension
            settingsTableView.estimatedRowHeight = 300
        }
    }
    
    private let searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        return searchController
    }()
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navigationVC = segue.destination as? UINavigationController, let vc = navigationVC.topViewController  else { return }
        vc.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
        vc.navigationItem.leftItemsSupplementBackButton = true
        if segue.identifier == SegueIdentifier.commonSettingWindow,
           let commonSettingVC = vc as? CommonSettingViewController,
           let SettingTypeKeys = sender as? SettingTypeKeys {
            
            commonSettingVC.settingTypeKeys = SettingTypeKeys
            
        }
    }
    
}
    
extension SettingsViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupSearchBar()
        addSettingsUpdationListener()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    private func addSettingsUpdationListener() {
        NotificationCenter.default.addObserver(forName: NSNotification.Name(StringLiterals.settingsUpdateNotification), object: nil, queue: nil) { [weak self] (notification) in
            self?.settingsTableView.reloadData()
        }
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
        if let switchCellData = cellData as? IconColoredSwitchCellViewModel {
            return setupSwitchCell(using: switchCellData, for: indexPath)
        } else if let forwardingCellData = cellData as? IconColoredForwardingCellViewModel {
            return setupForwardingCell(using: forwardingCellData, for: indexPath)
        }
        return UITableViewCell()
    }
    
}

    
extension SettingsViewController {
    
    private func setupForwardingCell(using forwardingCellData: IconColoredForwardingCellViewModel, for indexPath: IndexPath) -> UITableViewCell {
        let cell = settingsTableView.dequeueReusableCell(withIdentifier: IconForwardingTableViewCell.identifier, for: indexPath) as! IconForwardingTableViewCell
        var subtitle: String?
        switch forwardingCellData.type {
            case SettingTypeKeys.wiFi: subtitle = Settings.settings.wiFi?.name
            case SettingTypeKeys.carrier: subtitle = Settings.settings.carrier?.name
            case SettingTypeKeys.bluetooth: subtitle = Settings.settings.bluetooth ? "On" : "Off"
            default: subtitle = ""
        }
        cell.setup(details: forwardingCellData, subtitle: subtitle)
        return cell
    }

    private func setupSwitchCell(using switchCellData: IconColoredSwitchCellViewModel, for indexPath: IndexPath) -> UITableViewCell {
        let cell = settingsTableView.dequeueReusableCell(withIdentifier: IconSwitchTableViewCell.identifier, for: indexPath) as! IconSwitchTableViewCell
        cell.setup(details: switchCellData, isOn: Settings.settings.value(forKey: switchCellData.type.rawValue) as! Bool)
        return cell
    }


}


extension SettingsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let cellType = isFiltering ? filteredSettings[indexPath.row].type : tableDataSource[indexPath.section].cellsData[indexPath.row].type
        switch cellType {
        case .wiFi:
            presentAlert(controller: WiFi.alertForPresenting(objects: WiFi.connections, keyToUpdate: SettingTypeKeys.wiFi.rawValue), sourceView: tableView.cellForRow(at: indexPath))
        case .carrier:
            presentAlert(controller: Carrier.alertForPresenting(objects: Carrier.connections, keyToUpdate: SettingTypeKeys.carrier.rawValue), sourceView: tableView.cellForRow(at: indexPath))
        case .display:
            performSegue(withIdentifier: SegueIdentifier.displaySettingWindow, sender: nil)
        case .mobileData, .notifications, .bluetooth, .doNotDisturb, .general:
            performSegue(withIdentifier: SegueIdentifier.commonSettingWindow, sender: cellType)
        default:
            presentAlert(title: "End", message: "No where to go forward")
        }
    }
    
}


extension SettingsViewController {
    
    private var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    private var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    private func setupSearchBar() {
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
    
    
    private func filterContent(searchText: String) {
        filteredSettings.removeAll()
        tableDataSource.forEach { (sectionModel) in
            sectionModel.cellsData.forEach({ (cellModel) in
                cellModel.title.lowercased().contains(searchText.lowercased()) ? filteredSettings.append(cellModel) : ()
            })
        }
        settingsTableView.reloadData()
    }
    
}


extension SettingsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContent(searchText: searchController.searchBar.text!)
    }
}





