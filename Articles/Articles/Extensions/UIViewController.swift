//
//  UIViewController.swift
//  Articles
//
//  Created by Gabriel Conte on 03/03/20.
//  Copyright © 2020 Gabriel Conte. All rights reserved.
//

import UIKit

extension UIViewController{
    
    func showAlert(title: String, message: String, type: UIAlertController.Style = .alert, buttonMessage: String = "Ok", action: UIAlertAction? = nil) {
        let alertController = UIAlertController(title: title, message:
            message, preferredStyle: type)
        if let action = action {
            alertController.addAction(action)
        } else {
            alertController.addAction(UIAlertAction(title: buttonMessage, style: .default, handler: { (_) in }))
        }
        alertController.view.layoutIfNeeded()
        self.present(alertController, animated: true, completion: nil)
    }
}
