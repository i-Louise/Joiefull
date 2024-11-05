//
//  NetworkService.swift
//  Joiefull
//
//  Created by Louise Ta on 23/09/2024.
//

import Foundation

protocol NetworkServiceProtocol {
    func getAllArticles() async throws -> [Article]
}

class NetworkService: NetworkServiceProtocol {
    private let networkRequestExecutor: RequestExecutorProtocol

    init(networkRequestExecutor: RequestExecutorProtocol = NetworkRequestExecutor()) {
        self.networkRequestExecutor = networkRequestExecutor
    }
    
    func getAllArticles() async throws -> [Article] {
        let urlString = "https://raw.githubusercontent.com/OpenClassrooms-Student-Center/Cr-ez-une-interface-dynamique-et-accessible-avec-SwiftUI/main/api/clothes.json"
        
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let data = try await networkRequestExecutor.execute(request: request)
        print("Données brutes reçues : \(String(data: data, encoding: .utf8) ?? "aucune donnée")")
        do {
            let articlesData = try JSONDecoder().decode([Article].self, from: data)
            return articlesData
        } catch {
            print("Erreur de décodage : \(error)")
            throw NetworkError.decodingError
        }
    }
}
