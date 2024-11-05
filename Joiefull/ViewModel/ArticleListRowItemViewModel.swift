//
//  ArticleListRowItemViewModel.swift
//  Joiefull
//
//  Created by Louise Ta on 27/10/2024.
//

import Foundation

class ArticleListRowItemViewModel: ObservableObject {
    @Published var averageRating: Float? = nil
    
    let article: Article
    let like: Like
    
    private let reviewRepository: ReviewRepositoryProtocol
    
    init(article: Article, like: Like, reviewRepository: ReviewRepositoryProtocol) {
        self.article = article
        self.like = like
        self.reviewRepository = reviewRepository
        updateAverageRating()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(contextObjectsDidChange(_:)),
            name: Notification.Name.NSManagedObjectContextObjectsDidChange,
            object: nil
        )
    }
    
    @objc func contextObjectsDidChange(_ notification: Notification) {
        updateAverageRating()
    }
    
    private func updateAverageRating() {
        do {
            averageRating = try reviewRepository.getAverageRating(articleId: article.id)
        } catch {
            print("Impossible de calculer la moyenne")
            return
        }
    }
}
