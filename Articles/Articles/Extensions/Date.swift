//
//  Date.swift
//  Articles
//
//  Created by Gabriel Conte on 04/03/20.
//  Copyright © 2020 Gabriel Conte. All rights reserved.
//

import Foundation

public enum DateFormatterString: String {
    case dateWithoutTime = "MM/dd/yyyy"
}

extension String {
    
    func toDate(format: DateFormatterString) -> Date {
        let dateFormatter = Formatter.utc
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter.date(from: self)!
    }
}

extension Date {
    func toString(format: DateFormatterString) -> String {
        let dateFormatter = Formatter.utc
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter.string(from: self)
    }
}

extension Formatter {

    static var utc: DateFormatter = {
        let dateFormatter = DateFormatter()
        return dateFormatter
    }()

}
