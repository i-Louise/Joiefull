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
    @Published var errorMessage: String? = nil
    @Published var comment: String = ""
    @Published var rating: Int = 0
    @Published var userRating: Int = 0
    @Published var averageRating: Int = 0
    @Published var date: Date = Date()
    @Published var showingAlert = false
    @Published var reviews = [Review]()
    
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
        fetchReviews()
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
                    do {
                        try viewContext.save()
                        print("Avis sauvegardé avec succès.")
                    } catch {
                        print("Erreur lors de la sauvegarde : \(error)")
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                    print("Erreur lors de la récupération : \(error.localizedDescription)")
                }
            }
        }
    }
    
    func fetchReviews() {
        do {
            let data = ReviewRepository(viewContext: viewContext)
            reviews = try data.getReviews()
            averageRating = calculateAverageRating()
            print("Avis récupérés : \(reviews)")
        } catch {
            errorMessage = "Une erreur s'est produite lors de la récupération des derniers avis. Veuillez réessayer ultérieurement."
            showingAlert = true
        }
    }
    
    func calculateAverageRating() -> Int {
        guard !self.reviews.isEmpty else {
            print("Tentative de récupération des avis...\(reviews)")
            return 0
        }
        let totalRating = reviews.reduce(0) { $0 + Int($1.rating) }
        averageRating = Int(totalRating) / Int(reviews.count)
        
        return averageRating
    }
    
    func addReview() -> Bool {
        do {
            try ReviewRepository(viewContext: viewContext).addReview(comment: comment, date: date, rating: Int(userRating))
            return true
        } catch {
            errorMessage = "Une erreur est survenue lors de l'ajout. Veuillez réessayer"
            showingAlert = true
            return false
        }
    }
}
