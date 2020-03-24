//
//  RequestRouter.swift
//  Articles
//
//  Created by Gabriel Conte on 02/03/20.
//  Copyright © 2020 Gabriel Conte. All rights reserved.
//

import Foundation

protocol RequestComponents {
    var baseUrl: String { get }
    var path: String { get }
}

enum Router: RequestComponents {
    
    case articles
    
    var baseUrl: String {
        switch self {
        case .articles:
            return "https://www.ckl.io/"
        }
    }
    
    var path: String {
        switch self {
        case .articles:
            return "challenge/"
        }
    }
    
    var method: String {
      switch self {
      case .articles:
          return "GET"
      }
    }
}
