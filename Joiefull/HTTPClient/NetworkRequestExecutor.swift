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
    let executeDataRequest: (URLRequest) async throws -> (Data, URLResponse)
    
    init(executeDataRequest: @escaping (URLRequest) async throws -> (Data, URLResponse) = URLSession.shared.data(for:)) {
        self.executeDataRequest = executeDataRequest
    }
    
    func execute(request: URLRequest) async throws -> Data {
        let (data, response) = try await executeDataRequest(request)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw "HTTP error: \(response)"
        }
        return data
    }
}

extension String: Error {
    
}
