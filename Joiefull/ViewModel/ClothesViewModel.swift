//
//  WelcomeViewModel.swift
//  Joiefull
//
//  Created by Louise Ta on 23/09/2024.
//

import Foundation

class ClothesViewModel: ObservableObject {
    @Published var clothes: [Clothes] = []
    @Published var errorMessage: String? = nil
    private var networkService: NetworkServicing
    
    init(networkService: NetworkServicing = NetworkService()) {
        self.networkService = networkService
    }
    
    func fetchClothes() {
        Task {
            do {
                let clothesData = try await networkService.getAllClothes()
                print("Données récupérées : \(clothesData)")
                DispatchQueue.main.async {
                    self.clothes = clothesData
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                    print("Erreur lors de la récupération : \(error.localizedDescription)")
                }
            }
        }
    }

}
