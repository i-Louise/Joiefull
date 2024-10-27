//
//  ReviewRepository.swift
//  Joiefull
//
//  Created by Louise Ta on 11/10/2024.
//

import Foundation
import CoreData

class ReviewRepository {
    private let viewContext: NSManagedObjectContext
    
    init(viewContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.viewContext = viewContext
    }
    
    func getReviews() throws -> [Review] {
        let request = Review.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(SortDescriptor<Review>(\.date, order: .reverse))]
        return try viewContext.fetch(request)
    }
    
    func addReview(comment: String, date: Date, rating: Int) throws {
        let newReview = Review(context: viewContext)
        newReview.comment = comment
        newReview.date = date
        newReview.rating = Int16(rating)
        newReview.user = try UserRepository(viewContext: viewContext).getUser()
        try viewContext.save()
    }
}
