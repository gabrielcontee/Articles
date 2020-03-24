//
//  ArticleTableViewCell.swift
//  Articles
//
//  Created by Gabriel Conte on 03/03/20.
//  Copyright © 2020 Gabriel Conte. All rights reserved.
//

import UIKit

final class ArticleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var authorImageView: UIImageView!
    @IBOutlet weak var articleTitleLabel: UILabel!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var articleDateLabel: UILabel!
    @IBOutlet weak var alreadySeenMarkView: UIView!
    
    func setup(title: String, authorName: String, date: String, authorImageUrl: String, alreadyMarked: Bool){
        self.articleTitleLabel.text = title
        self.authorNameLabel.text = authorName
        self.articleDateLabel.text = date
        self.authorImageView.load(with: authorImageUrl)
        self.authorImageView.round()
        self.alreadySeenMarkView.round()
        self.alreadySeenMarkView.isHidden = alreadyMarked ? false : true
    }
    
}
