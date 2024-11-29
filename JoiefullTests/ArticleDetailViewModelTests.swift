//
//  ArticleDetailViewModelTests.swift
//  JoiefullTests
//
//  Created by Louise Ta on 05/11/2024.
//

import Foundation
import CoreData
import XCTest
@testable import Joiefull

final class ArticleDetailViewModelTests: XCTestCase {
    
    private var reviewRepositoryMock: ReviewRepositoryMock!
    
    override func setUp() {
        reviewRepositoryMock = ReviewRepositoryMock()
    }

    private let fakeArticle = Article(
        id: 0,
        name: "Sac à main orange posé sur une poignée de porte",
        likes: 40,
        price: 50,
        originalPrice: 60,
        category: Article.Category.accessoiries,
        picture: Article.Picture(url: "https://raw.githubusercontent.com/OpenClassrooms-Student-Center/Cr-ez-une-interface-dynamique-et-accessible-avec-SwiftUI/main/img/accessories/1.jpg", description: "Sac à main orange posé sur une poignée de porte")
    )
    private let fakeLike = Like(likes: 40, isLiked: false)
    
    // Given no average rating from reviews, When initialized, Then ensure average rating is nil
    func test_init_noAverageRating() {
        // Given
        reviewRepositoryMock.fakeAverageRating = nil
        // When
        let underTest = ArticleDetailViewModel(
            article: fakeArticle,
            like: fakeLike,
            reviewRepository: reviewRepositoryMock
        )
        // Then
        XCTAssertNil(underTest.averageRating)
    }

    // Given an average rating from reviews, When initialized, Then ensure average rating is correct
    func test_init_someAverageRating() {
        // Given
        reviewRepositoryMock.fakeAverageRating = 4.2
        // When
        let underTest = ArticleDetailViewModel(
            article: fakeArticle,
            like: fakeLike,
            reviewRepository: reviewRepositoryMock
        )
        // Then
        XCTAssertEqual(underTest.averageRating, 4.2)
    }
    
    // Given a user rating equal to 0, When adding a review, Then ensure the error message is set and alert is shown and no review is stored
    func test_userRatingEqualToZeroErrorMessage() {
        // Given
        let underTest = ArticleDetailViewModel(article: fakeArticle, like: fakeLike, reviewRepository: reviewRepositoryMock)
        let userRating = 0
        let userComment = "No comment"
        var isSuccessCalled = false
        
        // When
        underTest.addReview(userRating: userRating, userComment: userComment, onSuccess: {
            isSuccessCalled = true
        })
        
        // Then
        XCTAssertFalse(isSuccessCalled)
        XCTAssertEqual(underTest.alertMessage, "Veuillez renseigner une notation")
        XCTAssertTrue(underTest.showingAlert)
    }
    
    // Given a valid user rating, When adding a review, Then ensure the review is added
    func test_givenValidUserRating_whenAddingReview_thenEnsureReviewIsAdded() {
        // Given
        let underTest = ArticleDetailViewModel(article: fakeArticle, like: fakeLike, reviewRepository: reviewRepositoryMock)
        let userRating = 5
        let userComment = "No comment"
        var isSuccessCalled = false
        
        // When
        underTest.addReview(userRating: userRating, userComment: userComment, onSuccess: {
            isSuccessCalled = true
        })
        
        // Then
        XCTAssertTrue(isSuccessCalled)
        XCTAssertEqual(reviewRepositoryMock.reviewsCount, 1)
    }
}
