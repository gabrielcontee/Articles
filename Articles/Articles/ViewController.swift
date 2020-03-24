//
//  ViewController.swift
//  Articles
//
//  Created by Gabriel Conte on 02/03/20.
//  Copyright © 2020 Gabriel Conte. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Requester().execute(router: .articles) { (result: Result<[Article], Error>) in
            switch result {
            case .success(let articles):
                print(articles)
                break
            case .failure(let error):
                print(error.localizedDescription)
                print(error)
                break
            }
        }
    }


}

