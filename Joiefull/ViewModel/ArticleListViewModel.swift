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
    
    private let networkService: NetworkServiceProtocol
    private let articleRepository: ArticleRepository
    private let reviewRepository: ReviewRepository
    private let likeRepository: LikeRepository
    
    init(
        networkService: NetworkServiceProtocol = NetworkService(),
        articleRepository: ArticleRepository,
        reviewRepository: ReviewRepository,
        likeRepository: LikeRepository
    ) {
        self.networkService = networkService
        self.articleRepository = articleRepository
        self.reviewRepository = reviewRepository
        self.likeRepository = likeRepository
    }
    
    var categories: OrderedDictionary<String, [Article]> {
        OrderedDictionary(
            grouping: articles,
            by: { $0.category.rawValue }
        )
    }
    
    func fetchArticles(completion: @escaping () -> Void) {
        Task {
            do {
                let articlesData = try await networkService.getAllArticles()
                DispatchQueue.main.async { [self] in
                    articleRepository.articles = articlesData
                    articles = articleRepository.articles
                    populateLikes(articles: articles)
                    completion()
                }
            } catch {
                DispatchQueue.main.async { [self] in
                    errorMessage = error.localizedDescription
                    print("Erreur lors de la récupération : \(error.localizedDescription)")
                    completion()
                }
            }
        }
    }
    
    private func populateLikes(articles: [Article]) {
        articles.forEach { article in
            if likeRepository.likes[article.id] == nil {
                likeRepository.likes[article.id] = Like(likes: article.likes, isLiked: false)
            }
        }
    }
    
    func getArticleDetailViewModel(article: Article) -> ArticleDetailViewModel {
        return ArticleDetailViewModel(
            article: article,
            like: likeRepository.likes[article.id] ?? Like(likes: -1, isLiked: false),
            reviewRepository: reviewRepository
        )
    }
    
    func getArticleListRowItemViewModel(article: Article) -> ArticleListRowItemViewModel {
        return ArticleListRowItemViewModel(
            article: article,
            like: likeRepository.likes[article.id] ?? Like(likes: -1, isLiked: false),
            reviewRepository: reviewRepository
        )
    }
}
