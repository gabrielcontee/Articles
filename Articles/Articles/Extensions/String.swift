//
//  String.swift
//  Articles
//
//  Created by Gabriel Conte on 04/03/20.
//  Copyright © 2020 Gabriel Conte. All rights reserved.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + self.lowercased().dropFirst()
    }

    mutating func capitalizeFirstLetter() {
      self = self.capitalizingFirstLetter()
    }
}
