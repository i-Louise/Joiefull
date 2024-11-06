//
//  ArticleDetailViewModel.swift
//  Joiefull
//
//  Created by Louise Ta on 25/10/2024.
//

import Foundation
import CoreData

class ArticleDetailViewModel: ObservableObject {
    @Published var averageRating: Float? = nil
    @Published var userRating: Int = 0
    @Published var userComment: String = ""
    @Published var alertMessage: String? = nil
    @Published var showingAlert = false
    
    var article: Article
    var like: Like
    
    private let reviewRepository: ReviewRepositoryProtocol
    
    init(
        article: Article,
        like: Like,
        reviewRepository: ReviewRepositoryProtocol
    ) {
        self.article = article
        self.like = like
        self.reviewRepository = reviewRepository
        updateAverageRating()
    }
    
    func updateAverageRating() {
        do {
            averageRating = try reviewRepository.getAverageRating(articleId: article.id)
        } catch {
            alertMessage = "Une erreur s'est produite lors de la récupération des derniers avis. Veuillez réessayer ultérieurement."
            showingAlert = true
        }
    }
    
    func addReview() {
        guard userRating > 0 else {
            alertMessage = "Veuillez renseigner une notation"
            showingAlert = true
            return
        }
        do {
            try reviewRepository.addReview(
                articleId: article.id,
                comment: userComment,
                date: Date.now,
                rating: userRating
            )
            self.userRating = 0 
            self.userComment = ""
            alertMessage = "Votre avis a été ajouté avec succès !"
        } catch {
            alertMessage = "Une erreur est survenue lors de l'ajout. Veuillez réessayer"
            showingAlert = true
        }
    }
    
}
