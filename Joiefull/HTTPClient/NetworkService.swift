//
//  NetworkService.swift
//  Joiefull
//
//  Created by Louise Ta on 23/09/2024.
//

import Foundation

protocol NetworkServicing {
    func getAllClothes() async throws -> [Clothes]
}

class NetworkService: NetworkServicing {
    private let networkRequestExecutor: RequestExecutor

    init(networkRequestExecutor: RequestExecutor = NetworkRequestExecutor()) {
        self.networkRequestExecutor = networkRequestExecutor
    }
    
    func getAllClothes() async throws -> [Clothes] {
        let urlString = "https://raw.githubusercontent.com/OpenClassrooms-Student-Center/Cr-ez-une-interface-dynamique-et-accessible-avec-SwiftUI/main/api/clothes.json"
        
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let data = try await networkRequestExecutor.execute(request: request)
        print("Données brutes reçues : \(String(data: data, encoding: .utf8) ?? "aucune donnée")")
        do {
            let clothesData = try JSONDecoder().decode([Clothes].self, from: data)
            return clothesData
        } catch {
            print("Erreur de décodage : \(error)")
            throw NetworkError.decodingError
        }
    }
}
