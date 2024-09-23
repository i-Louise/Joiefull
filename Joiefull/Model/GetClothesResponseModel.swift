//
//  GetClothesResponseModel.swift
//  Joiefull
//
//  Created by Louise Ta on 23/09/2024.
//

import Foundation

struct GetClothesResponseModel: Decodable {
    let clothes: [Clothe]
}

struct Picture: Decodable, Hashable {
    let url: String
    let description: String
}

