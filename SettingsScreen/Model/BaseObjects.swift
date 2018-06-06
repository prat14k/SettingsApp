//
//  BaseObjects.swift
//  SettingsScreen
//
//  Created by Prateek Sharma on 6/1/18.
//  Copyright © 2018 Prateek Sharma. All rights reserved.
//

import UIKit
import RealmSwift


protocol BaseObjects {
    var name: String { get }
    init(name: String)
}
extension BaseObjects {
    
    static func connections<T>(with prefix: String) -> [T] where T: Object, T: BaseObjects {
        var objects = RealmService.shared.read(aClass: T.self)
        if objects.count == 0 {
            for i in 1...5 {
                objects.append(self.init(name: "\(prefix) \(i)") as! T)
            }
            try? RealmService.shared.create(objects: objects)
        }
        return objects
    }
    
    static func alertForPresenting<T>(objects: [T], keyToUpdate key: String) -> UIAlertController where T: Object, T: BaseObjects {
        let alertController = UIAlertController(title: nil, message: "Choose any one", preferredStyle: .actionSheet)
        for object in objects {
            alertController.addAction(UIAlertAction(title: object.name, style: .default, handler: { (action) in
                print(object)
                try? RealmService.shared.update(object: Settings.settings, with: [key : object])
                NotificationCenter.default.post(name: NSNotification.Name(StringLiterals.settingsUpdateNotification), object: nil)
            }))
        }
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        return alertController
    }
    
}

