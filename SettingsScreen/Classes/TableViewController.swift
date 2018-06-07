//
//  TableViewController.swift
//  SettingsScreen
//
//  Created by Prateek Sharma on 6/5/18.
//  Copyright © 2018 Prateek Sharma. All rights reserved.
//

import UIKit



class TableVC: UITableViewController, Maskable, RoundedSection {
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard UIScreen.isSplit  else { return }
        let roundedCorners = corners(for: indexPath.row, withTotalSectionRows: tableView.numberOfRows(inSection: indexPath.section))
        round(corners: roundedCorners, view: cell)
    }
}





