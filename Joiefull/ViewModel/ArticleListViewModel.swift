//
//  ArticleListViewModel.swift
//  Joiefull
//
//  Created by Louise Ta on 23/09/2024.
//

import Foundation
import CoreData
import OrderedCollections

class ArticleListViewModel: ObservableObject {
    @Published var articles: [Article] = []
    @Published var averageRating: Int = 0
    @Published var errorMessage: String? = nil
    @Published var showingAlert = false
    
    private let networkService: NetworkServicing
    private let articleRepository: ArticleRepository
    private let reviewRepository: ReviewRepository
    
    init(
        networkService: NetworkServicing = NetworkService(),
        articleRepository: ArticleRepository,
        reviewRepository: ReviewRepository
    ) {
        self.networkService = networkService
        self.articleRepository = articleRepository
        self.reviewRepository = reviewRepository
    }
    
    var categories: OrderedDictionary<String, [Article]> {
        OrderedDictionary(
            grouping: articles,
            by: { $0.category.rawValue }
        )
    }
    
    func fetchArticles() {
        Task {
            do {
                let articlesData = try await networkService.getAllArticles()
                DispatchQueue.main.async { [self] in
                    self.articleRepository.articles = articlesData
                    self.articles = self.articleRepository.articles
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                    print("Erreur lors de la récupération : \(error.localizedDescription)")
                }
            }
        }
    }
    
    func getArticleDetailViewModel(article: Article) -> ArticleDetailViewModel {
        return ArticleDetailViewModel(
            article: article,
            reviewRepository: reviewRepository
        )
    }
    
    func getArticleListRowItemViewModel(article: Article) -> ArticleListRowItemViewModel {
        return ArticleListRowItemViewModel(
            article: article,
            reviewRepository: reviewRepository
        )
    }
}
