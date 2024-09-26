//
//  NetworkError.swift
//  Joiefull
//
//  Created by Louise Ta on 27/09/2024.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case decodingError
    case unknown
}
