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
    @Published var userRating: Int? = nil
    @Published var userComment: String = ""
    @Published var errorMessage: String? = nil
    @Published var showingAlert = false
    
    let article: Article
    
    private let reviewRepository: ReviewRepository
    private let viewContext: NSManagedObjectContext
    
    init(
        article: Article,
        reviewRepository: ReviewRepository,
        viewContext: NSManagedObjectContext
    ) {
        self.article = article
        self.reviewRepository = reviewRepository
        self.viewContext = viewContext
    }
    
    func fetchReviews() {
        do {
            averageRating = try reviewRepository.getAverageRating(articleId: article.id)
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
                articleId: article.id,
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
}
