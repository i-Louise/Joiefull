//
//  ArticleDetailViewModel.swift
//  Joiefull
//
//  Created by Louise Ta on 25/10/2024.
//

import Foundation
import CoreData

class ArticleDetailViewModel: ObservableObject {
    @Published var averageRating: Int? = nil
    @Published var reviews = [Review]()
    @Published var userRating: Int? = nil
    @Published var userComment: String = ""
    @Published var errorMessage: String? = nil
    @Published var showingAlert = false
    
    private let reviewRepository: ReviewRepository
    private let viewContext: NSManagedObjectContext
    
    init(
        reviewRepository: ReviewRepository,
        viewContext: NSManagedObjectContext
    ) {
        self.reviewRepository = reviewRepository
        self.viewContext = viewContext
    }
    
    func fetchReviews() {
        do {
            reviews = try reviewRepository.getReviews()
            averageRating = calculateAverageRating(reviews: reviews)
            print("Avis récupérés : \(reviews)")
        } catch {
            errorMessage = "Une erreur s'est produite lors de la récupération des derniers avis. Veuillez réessayer ultérieurement."
            showingAlert = true
        }
    }
    
    func addReview() {
        do {
            guard let userRating else {
                errorMessage = "Veuillez renseigner une notation"
                showingAlert = true
                return
            }
            try reviewRepository.addReview(
                comment: userComment,
                date: Date.now,
                rating: Int(userRating)
            )
            self.userRating = nil
            self.userComment = ""
        } catch {
            errorMessage = "Une erreur est survenue lors de l'ajout. Veuillez réessayer"
            showingAlert = true
        }
    }
    
    // Returns nil if passed in review list is empty
    private func calculateAverageRating(reviews: [Review]) -> Int? {
        guard !reviews.isEmpty else {
            print("Il n'y a pas d'avis pour le moment...")
            return nil
        }
        let totalRating = reviews.reduce(0) { $0 + Int($1.rating) }
        return Int(totalRating) / Int(reviews.count)
    }
}
