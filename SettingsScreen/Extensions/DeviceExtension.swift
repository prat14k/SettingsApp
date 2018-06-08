//
//  DeviceExtension.swift
//  SettingsScreen
//
//  Created by Prateek Sharma on 6/8/18.
//  Copyright © 2018 Prateek Sharma. All rights reserved.
//

import UIKit


extension UIDevice {
    static let isIPad: Bool = current.userInterfaceIdiom == .pad
    static let isIPhone: Bool = current.userInterfaceIdiom == .phone
    class var isLandscape: Bool {
        let statusBarOrientation = UIApplication.shared.statusBarOrientation
        return statusBarOrientation == .landscapeLeft || statusBarOrientation == .landscapeRight
    }
}
