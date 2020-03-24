//
//  ArticlesTests.swift
//  ArticlesTests
//
//  Created by Gabriel Conte on 02/03/20.
//  Copyright © 2020 Gabriel Conte. All rights reserved.
//

import XCTest
@testable import Articles

class MockApi: RequestExecuter {
    
    let articlesMocked: [Article]
    
    init(articlesList: [Article]) {
        self.articlesMocked = articlesList
    }
    
    func execute<T>(router: Router, completion: @escaping (Result<T, Error>) -> ()) where T : Decodable, T : Encodable {
        
        let data = try! JSONEncoder().encode(articlesMocked)
        let responseObject = try! JSONDecoder().decode(T.self, from: data)

        completion(.success(responseObject))
    }
}

class ArticlesTests: XCTestCase {
    
    var articlesListViewModel: ArticlesListViewModel!
    
    var article0: Article!
    var article1: Article!
    var article2: Article!
    
    private func initializeMockApi() -> MockApi{
        article0 = Article(title: "ABC", website: "www.google.com", authors: "J. K. Rowling", date: "10/10/2019", imageUrl: "https://f.i.uol.com.br/fotografia/2019/12/19/15767992905dfc0c3ac6ad3_1576799290_3x2_md.jpg", tags:  [Tags(id: 1, label: "Politics")])
        article1 = Article(title: "DEF", website: "www.google1.com", authors: "Nora Roberts", date: "05/20/2018", imageUrl: "https://images.gr-assets.com/authors/1505847251p8/625.jpg", tags:  [Tags(id: 2, label: "Tech")])
        article2 = Article(title: "GHI", website: "www.google.com", authors: "Khaled Hosseini", date: "01/01/2018", imageUrl: "https://upload.wikimedia.org/wikipedia/commons/1/16/George_and_Laura_Bush_with_Khaled_Hosseini_in_2007_detail2.JPG", tags: [Tags(id: 3, label: "Science")])
        
        let mockClient = MockApi(articlesList: [article0, article1, article2])
        
        return mockClient
    }

    override func setUp() {

        let mockClient = initializeMockApi()
        
        articlesListViewModel = ArticlesListViewModel(apiClient: mockClient)

        let fetchExpectation = expectation(description: "FetchArticles")

        articlesListViewModel.apiClient.execute(router: .articles) { (result: Result<[Article], Error>) in
            switch result {
            case .success(let articlesFetched):
                fetchExpectation.fulfill()
                self.articlesListViewModel.articles = articlesFetched
                break
            case .failure(_):
                XCTFail("Should always load with success")
                break
            }
        }

        wait(for: [fetchExpectation], timeout: 3.0)
    }

    func testNumberOfArticles() {
        XCTAssert(articlesListViewModel.numberOfArticles() == 3)
        XCTAssertNotNil(articlesListViewModel.article(for: 0))
    }

    func testArticleAtIndex() {
        let articleForIndex = articlesListViewModel.article(for: 1)
        XCTAssert(articleForIndex?.authors == "Nora Roberts")
        XCTAssert(articleForIndex?.website == "www.google1.com")
        XCTAssert(articleForIndex?.date == "05/20/2018")
        XCTAssert(articleForIndex?.title == "DEF")
    }

    func testDateConvertion() {
        var dateComponents = DateComponents()
        dateComponents.year = 2018
        dateComponents.month = 05
        dateComponents.day = 20
        dateComponents.timeZone = TimeZone(abbreviation: "GMT-3")
        let userCalendar = Calendar.current
        let articleDateFromCalendar = userCalendar.date(from: dateComponents)
        
        guard let articleForIndex = articlesListViewModel.article(for: 1) else {
            XCTFail("article nil")
            return
        }
        
        XCTAssertEqual(articleForIndex.date.toDate(format: .dateWithoutTime), articleDateFromCalendar)
    }

    func testSort() {
        XCTAssertEqual(articlesListViewModel.sortType.first, SortType.author)
        articlesListViewModel.sort()
        XCTAssertEqual([article0, article2, article1], articlesListViewModel.articles)
    }
}
