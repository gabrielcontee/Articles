//
//  Tags.swift
//  Articles
//
//  Created by Gabriel Conte on 04/03/20.
//  Copyright © 2020 Gabriel Conte. All rights reserved.
//

import Foundation

struct Tags: Codable, Equatable {
    
    var id: Int
    var label: String
    
    init(id: Int, label: String) {
        self.id = id
        self.label = label
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case label = "label"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        label = try container.decode(String.self, forKey: .label)
    }
    
    static func == (lhs: Tags, rhs: Tags) -> Bool {
        return lhs.id == rhs.id
        && lhs.label == rhs.label
    }
}
