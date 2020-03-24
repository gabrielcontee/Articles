//
//  UIView.swift
//  Articles
//
//  Created by Gabriel Conte on 03/03/20.
//  Copyright © 2020 Gabriel Conte. All rights reserved.
//

import UIKit

extension UIView {

    func round() {
        self.layer.masksToBounds = false
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
}
