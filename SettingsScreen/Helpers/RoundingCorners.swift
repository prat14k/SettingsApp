//
//  RoundingCorners.swift
//  SettingsScreen
//
//  Created by Prateek Sharma on 6/6/18.
//  Copyright © 2018 Prateek Sharma. All rights reserved.
//

import UIKit


protocol RoundedSection { }
extension RoundedSection {
    func corners(for row: Int, withTotalSectionRows count: Int) -> CACornerMask {
        var corners: CACornerMask = []
        if row == 0 && row == (count-1) {
            corners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMinYCorner]
        } else if row == 0 {
            corners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        } else if row == (count-1) {
            corners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        }
        return corners
    }
}

protocol Maskable { }
extension Maskable {
    func round(corners: CACornerMask,view: UIView) {
        view.layer.cornerRadius = UIConstants.roundedSectionCornerRadius
        view.layer.masksToBounds = true
        view.layer.maskedCorners = corners
    }
}
