//
//  ReviewRepository.swift
//  Joiefull
//
//  Created by Louise Ta on 11/10/2024.
//

import Foundation
import CoreData

protocol ReviewRepositoryProtocol {
    func addReview(articleId: Int, comment: String, date: Date, rating: Int) throws
    func getAverageRating(articleId: Int) throws -> Float?
}

class ReviewRepository: ReviewRepositoryProtocol {
    private let viewContext: NSManagedObjectContext
    
    init(viewContext: NSManagedObjectContext) {
        self.viewContext = viewContext
    }
    
    private func getReviews(articleId: Int) throws -> [Review] {
        let request = Review.fetchRequest()
        request.predicate = NSPredicate(format: "articleId == %ld", Int64(articleId))
        request.sortDescriptors = [NSSortDescriptor(SortDescriptor<Review>(\.date, order: .reverse))]
        return try viewContext.fetch(request)
    }
    
    func addReview(articleId: Int, comment: String, date: Date, rating: Int) throws {
        let newReview = Review(context: viewContext)
        newReview.articleId = Int64(articleId)
        newReview.comment = comment
        newReview.date = date
        newReview.rating = Int16(rating)
        try viewContext.save()
    }
    
    func getAverageRating(articleId: Int) throws -> Float? {
        let reviews = try getReviews(articleId: articleId)
        guard !reviews.isEmpty else {
            print("Il n'y a pas d'avis pour le moment...")
            return nil
        }
        let totalRating = reviews.reduce(0) { $0 + Int($1.rating) }
        return Float(totalRating) / Float(reviews.count)
    }
}
