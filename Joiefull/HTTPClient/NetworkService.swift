//
//  NetworkService.swift
//  Joiefull
//
//  Created by Louise Ta on 23/09/2024.
//

import Foundation

protocol NetworkServicing {
    func getAllClothes() async throws -> GetClothesResponseModel
}

class NetworkService: NetworkServicing {
    let networkRequestExecutor: RequestExecutor

    init(networkRequestExecutor: RequestExecutor) {
        self.networkRequestExecutor = networkRequestExecutor
    }
    
    func getAllClothes() async throws -> GetClothesResponseModel {
        let url = URL(string: "https://raw.githubusercontent.com/OpenClassrooms-Student-Center/Cr-ez-une-interface-dynamique-et-accessible-avec-SwiftUI/main/api/clothes.json")!
        let request = try URLRequest(
            url: url,
            method: .GET
        )
        let data = try await networkRequestExecutor.execute(request: request)
        let clothesData = try JSONDecoder().decode(GetClothesResponseModel.self, from: data)
        
        return clothesData
    }
    
}
