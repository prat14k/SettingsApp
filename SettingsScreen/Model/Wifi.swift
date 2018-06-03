//
//  Wifi.swift
//  SettingsScreen
//
//  Created by Prateek Sharma on 6/1/18.
//  Copyright © 2018 Prateek Sharma. All rights reserved.
//

import Foundation
import RealmSwift


class WiFi: Object {
    
    @objc dynamic let id = UUID()
    @objc dynamic var name: String = ""
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }

}

extension WiFi {
    
    static let connections: [WiFi] = {
        var wifis = RealmService.shared.read(aClass: WiFi.self)
        if wifis.count == 0 {
            for i in 1...5 {
                wifis.append(WiFi(name: "Network \(i)"))
            }
            try? RealmService.shared.create(objects: wifis)
        }
        return wifis
    }()
    
}
