//
//  ArticleListViewModelTests.swift
//  JoiefullTests
//
//  Created by Louise Ta on 31/10/2024.
//

import XCTest
import CoreData
@testable import Joiefull

final class ArticleListViewModelTests: XCTestCase {
    private let networkMock: NetworkServiceMock = NetworkServiceMock()
    private let articleRepository = ArticleRepository()
    private let likeRepository = LikeRepository()
    private var viewModel: ArticleListViewModel!
    
    override func setUp() {
        viewModel = ArticleListViewModel(
            networkService: networkMock,
            articleRepository: articleRepository,
            reviewRepository: ReviewRepository(
                viewContext: NSManagedObjectContext.init(
                    concurrencyType: .privateQueueConcurrencyType
                )
            ),
            likeRepository: likeRepository
        )
    }
    
    // Given a successful network call, When fetching articles, Then ensure articles are fetched correctly
    func test_fetchArticles() async {
        // Given
        let expectation = XCTestExpectation(description: "Fetch articles succeeds")
        networkMock.shouldFail = false
        // When
        viewModel.fetchArticles { [self] in
            // Then
            XCTAssertEqual(articleRepository.articles.count, 2)
            XCTAssertEqual(likeRepository.likes.count, 2)
            ensurePopulateLikesCorrectness(articles: articleRepository.articles)
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 1)
    }
    
    private func ensurePopulateLikesCorrectness(articles: [Article]) {
        articles.forEach { article in
            let like = likeRepository.likes[article.id]!
            XCTAssertEqual(like.totalLikes, article.likes)
            XCTAssertEqual(like.isLiked, false)
        }
    }
    
    // Given a failed network call, When fetching articles, Then ensure no articles are fetched
    func test_fetchArticles_networkFail() async {
        // Given
        let expectation = XCTestExpectation(description: "Fetch articles fails")
        networkMock.shouldFail = true
        // When
        viewModel.fetchArticles { [self] in
            // Then
            XCTAssertEqual(articleRepository.articles.count, 0)
            XCTAssertEqual(likeRepository.likes.count, 0)
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 1)
    }
}
