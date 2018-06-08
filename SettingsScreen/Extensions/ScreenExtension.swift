//
//  ScreenExtension.swift
//  SettingsScreen
//
//  Created by Prateek Sharma on 6/8/18.
//  Copyright © 2018 Prateek Sharma. All rights reserved.
//

import UIKit

extension UIScreen {
    class var isSplit: Bool {
        return UIDevice.isIPad || UIDevice.isLandscape
    }
}
