//
//  DefaultData.swift
//  Joiefull
//
//  Created by Louise Ta on 11/10/2024.
//

import Foundation
import CoreData

struct DefaultData {
    let viewContext: NSManagedObjectContext
    init(viewContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.viewContext = viewContext
    }
    
    func randomDateInLastMonth() -> Date {
        let daysOffset = Int.random(in: 0...30)
        let today = Date()
        let randomDate = Calendar.current.date(byAdding: .day, value: -daysOffset, to: today)!
        return randomDate
    }
    
    func apply() throws {
        let userRepository = UserRepository(viewContext: viewContext)
        let reviewRepository = ReviewRepository(viewContext: viewContext)
        
        if (try? userRepository.getUser()) == nil {
            let initialUser = User(context: viewContext)
            initialUser.firstName = "Jane"
            initialUser.lastName = "Doe"
            initialUser.profilePicture = nil
            
            try viewContext.save()
                        
            if try reviewRepository.getReviews().isEmpty {
                let review1 = Review(context: viewContext)
                let review2 = Review(context: viewContext)
                let review3 = Review(context: viewContext)
                let review4 = Review(context: viewContext)
                let review5 = Review(context: viewContext)
                
                review1.date = Date()
                review1.user?.firstName = "Charlotte"
                review1.user?.lastName = "D."
                review1.comment = generateRandomComment()
                review1.date = Date()
                review1.rating = (1...5).randomElement()!
                
                review2.date = Date()
                review2.user?.firstName = "John"
                review2.user?.lastName = "B."
                review2.comment = generateRandomComment()
                review2.date = Date()
                review2.rating = (1...5).randomElement()!
                
                review3.date = Date()
                review3.user?.firstName = "Lucie"
                review3.user?.lastName = "C."
                review3.comment = generateRandomComment()
                review3.date = Date()
                review3.rating = (1...5).randomElement()!
                
                review4.date = Date()
                review4.user?.firstName = "Riccardo"
                review4.user?.lastName = "P."
                review4.comment = generateRandomComment()
                review4.date = Date()
                review4.rating = (1...5).randomElement()!
                
                review5.date = Date()
                review5.user?.firstName = "Louise"
                review5.user?.lastName = "T."
                review5.comment = generateRandomComment()
                review5.date = Date()
                review5.rating = (1...5).randomElement()!
            }
            try? viewContext.save()
        }
    }
    
    private func generateRandomComment() -> String {
        let comments = [
            "J'adore cet article !",
            "Qualité exceptionnelle.",
            "Je ne suis pas très satisfaite.",
            "Recommande vivement !",
            "Pas mal, mais pourrait être meilleur.",
            "Article plus beau en photo."
        ]
        return comments.randomElement() ?? "Commentaire générique."
    }
}
