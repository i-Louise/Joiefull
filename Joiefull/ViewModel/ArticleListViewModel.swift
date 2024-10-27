//
//  ArticleListViewModel.swift
//  Joiefull
//
//  Created by Louise Ta on 23/09/2024.
//

import Foundation
import CoreData

class ArticleListViewModel: ObservableObject {
    @Published var articles: [Article] = []
    @Published var averageRating: Int = 0
    @Published var errorMessage: String? = nil
    @Published var showingAlert = false
    
    private let networkService: NetworkServicing
    private let articleRepository: ArticleRepository
    private let viewContext: NSManagedObjectContext
    
    init(
        networkService: NetworkServicing = NetworkService(),
        articleRepository: ArticleRepository,
        context: NSManagedObjectContext
    ) {
        self.networkService = networkService
        self.articleRepository = articleRepository
        self.viewContext = context
    }
    
    var categories: [String: [Article]] {
        Dictionary(
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
}
