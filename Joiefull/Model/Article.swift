//
//  Article.swift
//  Joiefull
//
//  Created by Louise Ta on 23/09/2024.
//

import Foundation

struct Article: Codable, Identifiable {
    let id: Int
    let name: String
    let likes: Int
    let price: Double
    let originalPrice: Double
    let category: Category
    let picture: Picture
    
    enum Category: String, CaseIterable, Codable {
        case accessoiries = "ACCESSORIES"
        case bottoms = "BOTTOMS"
        case shoes = "SHOES"
        case tops = "TOPS"
    }
    
    struct Picture: Codable {
        let url: String
        let description: String
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case likes
        case price
        case originalPrice = "original_price"
        case category
        case picture
    }
}
