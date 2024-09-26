//
//  NetworkRequestExecutor.swift
//  Joiefull
//
//  Created by Louise Ta on 23/09/2024.
//

import Foundation

protocol RequestExecutor {
    func execute(request: URLRequest) async throws -> Data
}

class NetworkRequestExecutor: RequestExecutor {
    func execute(request: URLRequest) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.invalidResponse
        }
        return data
    }
}
