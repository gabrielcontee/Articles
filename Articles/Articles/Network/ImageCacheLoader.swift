//
//  ImageCacheLoader.swift
//  Articles
//
//  Created by Gabriel Conte on 03/03/20.
//  Copyright © 2020 Gabriel Conte. All rights reserved.
//

import SGImageCache

extension UIImageView {
    
    func load(with urlString: String) {
        if let image = SGImageCache.image(forURL: urlString) {
            self.image = image
        } else {
            SGImageCache.getImage(url: urlString) { [weak self] image in
                guard let self = self else { return }
                self.image = image
            }
        }
    }
}

