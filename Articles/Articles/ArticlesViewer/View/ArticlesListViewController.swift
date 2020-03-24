//
//  ArticlesListViewController.swift
//  Articles
//
//  Created by Gabriel Conte on 03/03/20.
//  Copyright © 2020 Gabriel Conte. All rights reserved.
//

import UIKit

class ArticlesListViewController: UIViewController {
    
    private let articleCellId = "articleCell"
    
    var coordinator: MainCoordinator?
    
    var barButtonItem: UIBarButtonItem?
    
    @IBOutlet weak var articlesTableView: UITableView!{
        didSet{
            articlesTableView.register(UINib(nibName: "ArticleTableViewCell", bundle: nil), forCellReuseIdentifier: articleCellId)
            articlesTableView.dataSource = self
            articlesTableView.delegate = self
        }
    }
    
    private let viewModel: ArticlesListViewModel
    
    init(with viewModel: ArticlesListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: Self.self), bundle: .main)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.articlesPopulatorDelegate = self
        viewModel.loadingDelegate = self
        viewModel.sortDelegate = self
        viewModel.fetchArticles()
        self.barButtonItem = UIBarButtonItem.init(title: "Sort", style: .plain, target: self, action: #selector(self.sort(sender:)))
        self.navigationItem.rightBarButtonItem = barButtonItem
    }
    
    @objc func sort(sender: UIBarButtonItem) {
        viewModel.sort()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ArticlesListViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfArticles()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: articleCellId, for: indexPath) as? ArticleTableViewCell, let articleInfo = viewModel.article(for: indexPath.row) else {
            return UITableViewCell()
        }
        
        cell.setup(title: articleInfo.title, authorName: articleInfo.authors, date: articleInfo.date, authorImageUrl: articleInfo.imageUrl, alreadyMarked: articleInfo.marked)
        
        return cell
    }
}

extension ArticlesListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let contextItem = UIContextualAction(style: .normal, title: "Mark") {  (contextualAction, view, boolValue) in
            guard let articleCell = tableView.cellForRow(at: indexPath) as? ArticleTableViewCell, let article = self.viewModel.article(for: indexPath.row) else {
                return
            }
            self.viewModel.toggleArticleFor(index: indexPath.row)
            articleCell.alreadySeenMarkView.isHidden = article.marked
        }
        contextItem.backgroundColor = .systemBlue
        let swipeActions = UISwipeActionsConfiguration(actions: [contextItem])
        
        return swipeActions
    }
}

extension ArticlesListViewController: TableReloadProtocol {
    
    func reloadData() {
        DispatchQueue.main.async {
            self.articlesTableView.reloadData()
        }
    }
}

extension ArticlesListViewController: LoadableProtocol {
    
    func alreadyLoaded() {
        DispatchQueue.main.async {
            self.barButtonItem?.isEnabled = true
            Spinner.stop()
        }
    }
    
    func loadError(_ error: Error) {
        DispatchQueue.main.async {
            Spinner.stop()
            self.showAlert(title: "Error in fetch", message: error.localizedDescription)
        }
    }
    
    func isLoading() {
        DispatchQueue.main.async {
            self.barButtonItem?.isEnabled = false
            Spinner.start(from: self.view)
        }
    }
    
}

extension ArticlesListViewController: SortTypeProtocol {
    
    func sortedBy(type: String) {
        DispatchQueue.main.async {
            self.barButtonItem?.title = type.capitalizingFirstLetter()
            self.articlesTableView.reloadData()
        }
    }
}
