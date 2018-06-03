//
//  SettingsViewController.swift
//  SettingsScreen
//
//  Created by Prateek Sharma on 5/31/18.
//  Copyright © 2018 Prateek Sharma. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    
    let tableDataSource: [[SettingsCellModel]] = [
                            [
                                SwitchCellModel(title: StringLiterals.airplaneMode, key: SettingObserverKeys.airplaneMode, type: SettingType.airplaneMode),
                                DisclosureCellModel(title: StringLiterals.wiFi, key: SettingObserverKeys.wiFi, type: SettingType.wiFi),
                                DisclosureCellModel(title: StringLiterals.bluetooth, key: SettingObserverKeys.bluetooth, type: SettingType.bluetooth),
                                DisclosureCellModel(title: StringLiterals.mobileData, key: SettingObserverKeys.mobileData, type: SettingType.mobileData),
                                DisclosureCellModel(title: StringLiterals.carrier, key: SettingObserverKeys.carrier, type: SettingType.carrier)
                            ],
                            [
                                DisclosureCellModel(title: StringLiterals.notifications, key: SettingObserverKeys.notifications, type: SettingType.notifications),
                                DisclosureCellModel(title: StringLiterals.doNotDisturb, key: SettingObserverKeys.doNotDisturb, type: SettingType.doNotDisturb)
                            ],
                            [
                                DisclosureCellModel(title: StringLiterals.general, key: .none, type: SettingType.general),
                                DisclosureCellModel(title: StringLiterals.wallpaper, key: .none, type: SettingType.wallpaper),
                                DisclosureCellModel(title: StringLiterals.display, key: .none, type: SettingType.display)
                            ]
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
    
    // MARK: - View Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup the Search Controller
//        setupSearchBar()
        
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
        searchController.searchBar.delegate = self
    }
    
//    // MARK: - Private instance methods
//    func filterContent(searchText: String) {
//        filtereddata = data.filter({(text: String) -> Bool in
//            return text.lowercased().contains(searchText.lowercased())
//        })
//        settingsTableView.reloadData()
//    }
}

extension SettingsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableDataSource.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return isFiltering ? filtereddata.count : data.count
        return tableDataSource[section].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellData = tableDataSource[indexPath.section][indexPath.row]
        
        switch cellData {
        case let data as SwitchCellModel:
            let cell = tableView.dequeueReusableCell(withIdentifier: SwitchTableViewCell.identifier, for: indexPath) as! SwitchTableViewCell
            cell.setup(details: data, isOn: Settings.settings.value(forKey: data.key.rawValue) as! Bool)
            return cell
        case let data as DisclosureCellModel:
            let cell = tableView.dequeueReusableCell(withIdentifier: DisclosureTableViewCell.identifier, for: indexPath) as! DisclosureTableViewCell
            var subtitle: String?
            switch data.type {
            case SettingType.wiFi : subtitle = Settings.settings.wiFi?.name
            case SettingType.carrier : subtitle = Settings.settings.carrier?.name
            case SettingType.bluetooth : subtitle = Settings.settings.bluetooth ? "On" : "Off"
            default : subtitle = ""
            }
            cell.setup(details: data, subtitle: subtitle)
            return cell
        default:
            return UITableViewCell()
        }
        
    }
    
}
extension SettingsViewController: UITableViewDelegate { }


extension SettingsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
//        filterContent(searchText: searchController.searchBar.text!)
    }
}

extension SettingsViewController: UISearchBarDelegate {
    
}





