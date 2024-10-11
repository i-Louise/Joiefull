//
//  Clothe.swift
//  Joiefull
//
//  Created by Louise Ta on 23/09/2024.
//

import Foundation
import SwiftUI

struct Clothes: Hashable, Codable, Identifiable {
    let id: Int
    let name: String
    let likes: Int
    let price: Double
    let original_price: Double
    var isFavorite: Bool? = false
    
    var category: Category
    enum Category: String, CaseIterable, Codable {
        case accessoiries = "ACCESSORIES"
        case bottoms = "BOTTOMS"
        case shoes = "SHOES"
        case tops = "TOPS"
    }
    
    var picture: Picture
    struct Picture: Hashable, Codable {
        var url: String
        var description: String
    }
}
