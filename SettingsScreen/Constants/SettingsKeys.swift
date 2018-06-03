//
//  SettingsKeys.swift
//  SettingsScreen
//
//  Created by Prateek Sharma on 6/1/18.
//  Copyright © 2018 Prateek Sharma. All rights reserved.
//

import Foundation


enum SettingObserverKeys: String {

    case airplaneMode = "airplaneMode"
    case wiFi = "wiFi"
    case bluetooth = "bluetooth"
    case mobileData = "mobileData"
    case carrier = "carrier"
    case notifications = "notifications"
    case doNotDisturb = "doNotDisturb"
    case none
}


enum SettingType {
    
    case airplaneMode
    case wiFi
    case bluetooth
    case mobileData
    case carrier
    case notifications
    case doNotDisturb
    case general
    case wallpaper
    case display
    
}


