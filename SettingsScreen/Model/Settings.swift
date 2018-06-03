//
//  Settings.swift
//  SettingsScreen
//
//  Created by Prateek Sharma on 6/1/18.
//  Copyright © 2018 Prateek Sharma. All rights reserved.
//

import Foundation
import RealmSwift


class Settings: Object {

    @objc dynamic var airplaneMode = false
    @objc dynamic var wiFi: WiFi?
    @objc dynamic var bluetooth = false
    @objc dynamic var mobileData = false
    @objc dynamic var carrier: Carrier?
    @objc dynamic var notifications = false
    @objc dynamic var doNotDisturb = false


    static let settings: Settings = {
        var setting = RealmService.shared.read(aClass: Settings.self).first
        if setting == nil {
            setting = Settings()
            try? RealmService.shared.create(object: setting!)
        }
        return setting!
    }()
    
}
