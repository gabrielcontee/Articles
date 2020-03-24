//
//  ArticlesViewModel.swift
//  Articles
//
//  Created by Gabriel Conte on 03/03/20.
//  Copyright © 2020 Gabriel Conte. All rights reserved.
//

import Foundation

protocol LoadableProtocol: class {
    func isLoading()
    func alreadyLoaded()
    func loadError(_ error: Error)
}

protocol TableReloadProtocol: class {
    func reloadData()
}

protocol SortTypeProtocol: class {
    func sortedBy(type: String)
}

enum SortType: String, CaseIterable {
    case author
    case title
    case date
    case subject
}

final class ArticlesListViewModel: NSObject {
    
    private typealias Marked = Bool
    
    weak var loadingDelegate: LoadableProtocol?
    weak var articlesPopulatorDelegate: TableReloadProtocol?
    weak var sortDelegate: SortTypeProtocol?
    
    var articles: [Article] = []
    
    private(set) var sortType: [SortType] = SortType.allCases
    
    let apiClient: RequestExecuter
    
    init(apiClient: RequestExecuter) {
        self.apiClient = apiClient
    }
    
    // MARK: - Table population functions
    
    func fetchArticles() {
        self.loadingDelegate?.isLoading()
        
        apiClient.execute(router: .articles) { [weak self] (result: Result<[Article], Error>) in
            guard let self = self else { return }
            switch result {
            case .success(let articles):
                self.articles = articles
                self.loadingDelegate?.alreadyLoaded()
                self.articlesPopulatorDelegate?.reloadData()
                break
            case .failure(let error):
                self.loadingDelegate?.loadError(error)
                break
            }
        }
    }
    
    func numberOfArticles() -> Int {
        return articles.count
    }
    
    func article(for index: Int) -> Article? {
        guard articles.count > index else {
            return nil
        }
        return articles[index]
    }
    
    // MARK: - Sort articles function
    
    func sort() {
        guard let type = sortType.first else { return }
        sortType.shiftInPlace()
        switch type {
        case .author:
            articles.sort(by: {$0.authors < $1.authors})
            break
        case .title:
            articles.sort(by: {$0.title < $1.title})
            break
        case .date:
            articles.sort(by: {$0.date.toDate(format: .dateWithoutTime) < $1.date.toDate(format: .dateWithoutTime)})
        case .subject:
            articles.sort(by: {$0.tags.first?.label ?? "" < $1.tags.first?.label ?? ""})
            break
        }
        self.articlesPopulatorDelegate?.reloadData()
        self.sortDelegate?.sortedBy(type: "Sorting: \(type.rawValue)")
    }
    
    // MARK: - Toggle articles function
    
    func toggleArticleFor(index: Int) {
        guard articles.count > index else {
            return
        }
        articles[index].marked.toggle()
    }
}
