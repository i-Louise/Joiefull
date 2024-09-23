//
//  WelcomeViewModel.swift
//  Joiefull
//
//  Created by Louise Ta on 23/09/2024.
//

import Foundation

class WelcomeViewModel: ObservableObject {
    @Published var allClothes: [Clothe] = []
    
    let networkService: NetworkServicing
    let clotheStorage: ClotheStorage
    
    init(
        clotheStorage: ClotheStorage,
        networkService: NetworkServicing
    ) {
        self.clotheStorage = clotheStorage
        self.networkService = networkService
    }
    
    func getClothes(completion: @escaping () -> Void) {
        Task {
            do {
                let clothesData = try await networkService.getAllClothes()
                
                DispatchQueue.main.async {
                    self.clotheStorage.clothes = clothesData.clothes
                    
                    completion()
                }

            } catch {
                DispatchQueue.main.async {
                    self.clotheStorage.clothes = [] 
                    completion()
                }
            }
        }
    }
}
