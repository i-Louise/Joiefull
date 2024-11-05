//
//  ReviewRepositoryMock.swift
//  JoiefullTests
//
//  Created by Louise Ta on 05/11/2024.
//

import Foundation
@testable import Joiefull

class ReviewRepositoryMock: ReviewRepositoryProtocol {
    private var reviews: [Review] = []
    var fakeAverageRating: Float? = nil
    
    func getReviews(articleId: Int) throws -> [Review] {
        return reviews
    }
    
    func addReview(articleId: Int, comment: String, date: Date, rating: Int) throws {
        let review = Review()
        review.articleId = Int64(articleId)
        review.comment = comment
        review.date = date
        review.rating = Int16(rating)
        reviews.append(review)
    }
    
    func getAverageRating(articleId: Int) throws -> Float? {
        return fakeAverageRating
    }
}
