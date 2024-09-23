//
//  Clothe.swift
//  Joiefull
//
//  Created by Louise Ta on 23/09/2024.
//

import Foundation

struct Clothe: Decodable, Hashable {
    let id: Int
    let picture: Picture
    let name: String
    let category: String
    let likes: Int
    let price: Double
    let original_price: Double
}
