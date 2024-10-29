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
    @Published var userRating: Int? = nil
    @Published var userComment: String = ""
    @Published var errorMessage: String? = nil
    @Published var showingAlert = false
    
    var article: Article
    var like: Like
    
    private let reviewRepository: ReviewRepository
    
    init(
        article: Article,
        like: Like,
        reviewRepository: ReviewRepository
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
