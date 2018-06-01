//
//  SettingsViewController.swift
//  SettingsScreen
//
//  Created by Prateek Sharma on 5/31/18.
//  Copyright © 2018 Prateek Sharma. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    var filtereddata = [String]()
    
    var data = [
        [
            ["cellIdentifier" : "switchCellIdentifier", "state" : false, "title": "Airplane Mode"],
            ["cellIdentifier" : "disclosureCellIdentifier", "state" : false,  "title": "WiFi", "subtitle" : "cham"],
            ["cellIdentifier" : "disclosureCellIdentifier", "state" : false,  "title": "Bluetooth", "subtitle" : "cham"],
            ["cellIdentifier" : "disclosureCellIdentifier", "state" : false,  "title": "Mobile Data", "subtitle" : ""],
            ["cellIdentifier" : "disclosureCellIdentifier", "state" : false,  "title": "Carrier", "subtitle" : "cham"]
        ],
        [
            ["cellIdentifier" : "disclosureCellIdentifier", "state" : false,  "title": "Notifications", "subtitle" : ""],
            ["cellIdentifier" : "disclosureCellIdentifier", "state" : false,  "title": "Do Not Disturb", "subtitle" : ""]
        ],
        [
            ["cellIdentifier" : "disclosureCellIdentifier", "state" : false,  "title": "General", "subtitle" : ""],
            ["cellIdentifier" : "disclosureCellIdentifier", "state" : false,  "title": "Wallpaper", "subtitle" : ""],
            ["cellIdentifier" : "disclosureCellIdentifier", "state" : false,  "title": "Display & Brightness", "subtitle" : ""]
        ]
    ]

    
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
        return data.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return isFiltering ? filtereddata.count : data.count
        return data[section].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellData = data[indexPath.section][indexPath.row]
        
        switch cellData["cellIdentifier"] as! String {
        case DisclosureTableViewCell.identifier :
            let cell = tableView.dequeueReusableCell(withIdentifier: DisclosureTableViewCell.identifier, for: indexPath) as! DisclosureTableViewCell
            cell.setup(details: cellData)
            return cell
        case SwitchTableViewCell.identifier :
            let cell = tableView.dequeueReusableCell(withIdentifier: SwitchTableViewCell.identifier, for: indexPath) as! SwitchTableViewCell
        cell.setup(details: cellData)
        return cell
        default:
            print("not found \(cellData)")
        }
        
        return UITableViewCell()
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





