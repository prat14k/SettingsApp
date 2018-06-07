//
//  Extensions.swift
//  SettingsScreen
//
//  Created by Prateek Sharma on 6/6/18.
//  Copyright © 2018 Prateek Sharma. All rights reserved.
//

import UIKit


extension UITableViewHeaderFooterView {
    override open var frame: CGRect {
        get {
            return super.frame
        }
        set(newFrame) {
            var frame = newFrame
            if UIScreen.isSplit {
                let indent = UITableView.indent()
                frame.origin.x   += indent
                frame.size.width -= indent * 2
            }
            super.frame = frame
        }
    }
}



extension UIScreen {
    class var isSplit: Bool {
        return UIDevice.isIPad || UIDevice.isLandscape
    }
}


extension UIDevice {
    static let isIPad: Bool = current.userInterfaceIdiom == .pad
    static let isIPhone: Bool = current.userInterfaceIdiom == .phone
    class var isLandscape: Bool {
        let statusBarOrientation = UIApplication.shared.statusBarOrientation
        return statusBarOrientation == .landscapeLeft || statusBarOrientation == .landscapeRight
    }
}


extension UITableView {
    
    static let indentByDeviceOrientation: (portrait: CGFloat, landscape: CGFloat) = {
        return UIDevice.isIPad ? (portrait: 20, landscape: 90) : (portrait: 0, landscape: 10)
    }()
    
    class func indent(isLandscape: Bool = UIDevice.isLandscape) -> CGFloat {
        return isLandscape ? indentByDeviceOrientation.landscape : indentByDeviceOrientation.portrait
    }
    
}


extension UIAlertController {
    
    func setupPopOverPresentation(sourceView: UIView!) {
        let popOver = popoverPresentationController
        popOver?.sourceView = sourceView
        popOver?.sourceRect = sourceView.bounds
        popOver?.permittedArrowDirections = .any
    }
    
    static var okayButton: UIAlertAction { return UIAlertAction(title: "Okay", style: .default, handler: nil) }
    
    static func create(title: String? = nil, message: String? = nil, style: UIAlertControllerStyle = .alert, actions: [UIAlertAction] = [okayButton]) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        actions.forEach { (action) in
            alertController.addAction(action)
        }
        return alertController
    }
}

extension UIViewController {
    
    func presentAlert(controller: UIAlertController, sourceView: UIView?) {
        controller.setupPopOverPresentation(sourceView: sourceView ?? view)
        self.present(controller, animated: true, completion: nil)
    }
    
    func presentAlert(title: String?, message: String?) {
        let controller = UIAlertController.create(title: title, message: message)
        presentAlert(controller: controller, sourceView: view)
    }
    
}


