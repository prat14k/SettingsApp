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
                                DisclosureCellModel(title: StringLiterals.wiFi, type: SettingType.wiFi),
                                DisclosureCellModel(title: StringLiterals.bluetooth, type: SettingType.bluetooth),
                                DisclosureCellModel(title: StringLiterals.mobileData, type: SettingType.mobileData),
                                DisclosureCellModel(title: StringLiterals.carrier, type: SettingType.carrier)
                            ],
                            [
                                DisclosureCellModel(title: StringLiterals.notifications, type: SettingType.notifications),
                                DisclosureCellModel(title: StringLiterals.doNotDisturb, type: SettingType.doNotDisturb)
                            ],
                            [
                                DisclosureCellModel(title: StringLiterals.general, type: SettingType.general),
                                DisclosureCellModel(title: StringLiterals.wallpaper, type: SettingType.wallpaper),
                                DisclosureCellModel(title: StringLiterals.display, type: SettingType.display)
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
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifier.toggledSettingWindow {
            if let vc = segue.destination as? SingleSettingViewController, let settingType = sender as? SettingType {
                switch settingType {
                case .mobileData:
                    vc.navBarTitle = StringLiterals.cellular
                    vc.tableDataSource = DataSource.cellularDataTableDB
                case .bluetooth:
                    vc.navBarTitle = StringLiterals.bluetooth
                    vc.tableDataSource = DataSource.bluetoothTableDB
                case .notifications:
                    vc.navBarTitle = StringLiterals.notifications
                    vc.tableDataSource = DataSource.notificationsTableDB
                case .doNotDisturb:
                    vc.navBarTitle = StringLiterals.doNotDisturb
                    vc.tableDataSource = DataSource.doNotDisturbTableDB
                case .general:
                    vc.navBarTitle = StringLiterals.general
                    vc.tableDataSource = DataSource.generalSettingTableDB
                default: print("Unknown Type")
                }
            }
            
        }
    }
    
    
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
extension SettingsViewController: UITableViewDelegate {
    
    func presentWifiOptions() {
        let alertController = UIAlertController(title: nil, message: "Choose any one", preferredStyle: .actionSheet)
        for wifi in WiFi.connections {
            alertController.addAction(UIAlertAction(title: wifi.name, style: .default, handler: { (action) in
                print(wifi)
                try? RealmService.shared.update(object: Settings.settings, with: [SettingObserverKeys.wiFi.rawValue : wifi])
            }))
        }
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func presentCarrierOptions() {
        let alertController = UIAlertController(title: nil, message: "Choose any one", preferredStyle: .actionSheet)
        for carrier in Carrier.connections {
            alertController.addAction(UIAlertAction(title: carrier.name, style: .default, handler: { (action) in
                print(carrier)
                try? RealmService.shared.update(object: Settings.settings, with: [SettingObserverKeys.carrier.rawValue : carrier])
            }))
        }
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellType = tableDataSource[indexPath.section][indexPath.row].type
        switch cellType {
        case .wiFi:
            presentWifiOptions()
        case .carrier:
            presentCarrierOptions()
        case .display:
            performSegue(withIdentifier: SegueIdentifier.displaySettingWindow, sender: nil)
        case .mobileData, .notifications, .bluetooth, .doNotDisturb, .general:
            performSegue(withIdentifier: SegueIdentifier.toggledSettingWindow, sender: cellType)
        default:
            print("as")
        }
    }
    
}


extension SettingsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
//        filterContent(searchText: searchController.searchBar.text!)
    }
}

extension SettingsViewController: UISearchBarDelegate {
    
}





