//
//  MainCoordinator.swift
//  Articles
//
//  Created by Gabriel Conte on 03/03/20.
//  Copyright © 2020 Gabriel Conte. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator{
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    let clientProvider: Requester = Requester()

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        configureNavBar()
    }
    
    func start() {
        let viewModel = ArticlesListViewModel(apiClient: Requester())
        let articlesListVC = ArticlesListViewController(with: viewModel)
        articlesListVC.title = "News"
        
        articlesListVC.coordinator = self
        navigationController.pushViewController(articlesListVC, animated: false)
    }
    
    private func configureNavBar() {
        self.navigationController.navigationBar.barTintColor = Colors.navBarColor
        self.navigationController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        self.navigationController.navigationBar.layer.masksToBounds = false
        self.navigationController.navigationBar.layer.shadowColor = UIColor.lightGray.cgColor
        self.navigationController.navigationBar.layer.shadowOpacity = 0.8
        self.navigationController.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 0.5)
        self.navigationController.navigationBar.layer.shadowRadius = 1
    }
}


