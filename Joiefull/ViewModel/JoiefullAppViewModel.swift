//
//  JoiefullAppViewModel.swift
//  Joiefull
//
//  Created by Louise Ta on 29/10/2024.
//

import Foundation

class JoiefullAppViewModel {
    private let persistenceController: PersistenceController
    private let articleRepository: ArticleRepository
    private let reviewRepository: ReviewRepository
    
    init() {
        persistenceController = PersistenceController()
        articleRepository = ArticleRepository()
        reviewRepository = ReviewRepository(
            viewContext: persistenceController.container.viewContext
        )
    }
    
    var articleListViewModel: ArticleListViewModel {
        return ArticleListViewModel(
            articleRepository: articleRepository,
            reviewRepository: reviewRepository
        )
    }
}
