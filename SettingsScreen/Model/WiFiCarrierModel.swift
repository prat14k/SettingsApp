//
//  WiFiCarrierModel.swift
//  SettingsScreen
//
//  Created by Prateek Sharma on 6/6/18.
//  Copyright © 2018 Prateek Sharma. All rights reserved.
//

import Foundation
import RealmSwift

final class WiFi: Object {
    @objc dynamic var name: String = ""
    convenience init(name: String) {
        self.init()
        self.name = name
    }
}
extension WiFi: BaseObjects {
    static let connections: [WiFi] = WiFi.connections(with: "Network")
}


final class Carrier: Object {
    @objc dynamic var name: String = ""
    convenience init(name: String) {
        self.init()
        self.name = name
    }
}
extension Carrier: BaseObjects {
    static let connections: [Carrier] = Carrier.connections(with: "Carrier")
}
