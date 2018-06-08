//
//  ViewControllerExtension.swift
//  SettingsScreen
//
//  Created by Prateek Sharma on 6/6/18.
//  Copyright © 2018 Prateek Sharma. All rights reserved.
//

import UIKit


extension UIViewController {
    
    func presentAlert(controller: UIAlertController, sourceView: UIView?) {
        controller.setupPopOverPresentation(sourceView: sourceView ?? view)
        DispatchQueue.main.async { [weak self] in
            self?.present(controller, animated: true, completion: nil)
        }
    }
    
    func presentAlert(title: String?, message: String?) {
        let controller = UIAlertController.create(title: title, message: message)
        presentAlert(controller: controller, sourceView: view)
    }
    
}


