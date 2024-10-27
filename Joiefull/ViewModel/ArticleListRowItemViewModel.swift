//
//  ArticleListRowItemViewModel.swift
//  Joiefull
//
//  Created by Louise Ta on 27/10/2024.
//

import Foundation

class ArticleListRowItemViewModel: ObservableObject {
    let article: Article
    
    private let reviewRepository: ReviewRepository
    
    init(article: Article, reviewRepository: ReviewRepository) {
        self.article = article
        self.reviewRepository = reviewRepository
    }
    
    func getRating() -> Float? {
        do {
            return try reviewRepository.getAverageRating(articleId: article.id)
        } catch {
            print("Impossible de calculer la moyenne")
            return nil
        }
    }
}
