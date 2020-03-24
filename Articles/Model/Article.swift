//
//  Article.swift
//  Articles
//
//  Created by Gabriel Conte on 02/03/20.
//  Copyright © 2020 Gabriel Conte. All rights reserved.
//

import Foundation

struct Article: Codable, Equatable {

    var marked: Bool = false
    var title: String
    var website: String
    var authors: String
    var date: String
    var imageUrl: String
    var tags: [Tags]
    
    init(title: String, website: String, authors: String, date: String, imageUrl: String, tags: [Tags]) {
        self.title = title
        self.website = website
        self.authors = authors
        self.date = date
        self.imageUrl = imageUrl
        self.tags = tags
    }
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case website = "website"
        case authors = "authors"
        case date = "date"
        case imageUrl = "image_url"
        case tags = "tags"
        case marked = "marked"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        website = try container.decode(String.self, forKey: .website)
        authors = try container.decode(String.self, forKey: .authors)
        date = try container.decode(String.self, forKey: .date)
        imageUrl = try container.decode(String.self, forKey: .imageUrl)
        tags = try container.decode([Tags].self, forKey: .tags)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(website, forKey: .website)
        try container.encode(authors, forKey: .authors)
        try container.encode(date, forKey: .date)
        try container.encode(imageUrl, forKey: .imageUrl)
        try container.encode(tags, forKey: .tags)
        try container.encode(marked, forKey: .marked)
    }
    
    static func == (lhs: Article, rhs: Article) -> Bool {
        return lhs.title == rhs.title
        && lhs.website == rhs.website
        && lhs.authors == rhs.authors
        && lhs.date == rhs.date
        && lhs.imageUrl == rhs.imageUrl
        && lhs.tags == rhs.tags
    }
}

