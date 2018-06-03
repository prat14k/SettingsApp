//
//  Carrier.swift
//  SettingsScreen
//
//  Created by Prateek Sharma on 6/1/18.
//  Copyright © 2018 Prateek Sharma. All rights reserved.
//

import Foundation
import RealmSwift


class Carrier: Object {
    
    @objc dynamic let id = UUID()
    @objc dynamic var name: String = ""
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }
    
}


extension Carrier {
    
    static let connections: [Carrier] = {
        var carriers = RealmService.shared.read(aClass: Carrier.self)
        if carriers.count == 0 {
            for i in 1...5 {
                carriers.append(Carrier(name: "Carrier \(i)"))
            }
            try? RealmService.shared.create(objects: carriers)
        }
        return carriers
    }()
    
}
