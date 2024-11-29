//
//  ReviewRepositoryMock.swift
//  JoiefullTests
//
//  Created by Louise Ta on 05/11/2024.
//

import Foundation
@testable import Joiefull

class ReviewRepositoryMock: ReviewRepositoryProtocol {
    private(set) var reviewsCount: Int = 0
    var fakeAverageRating: Float? = 4
    
    func addReview(articleId: Int, comment: String, date: Date, rating: Int) throws {
        reviewsCount += 1
    }
    
    func getAverageRating(articleId: Int) throws -> Float? {
        return fakeAverageRating
    }
}
