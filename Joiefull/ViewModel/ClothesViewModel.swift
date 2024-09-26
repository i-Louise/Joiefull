//
//  WelcomeViewModel.swift
//  Joiefull
//
//  Created by Louise Ta on 23/09/2024.
//

import Foundation

class ClothesViewModel: ObservableObject {
    @Published var clothes: [Clothes] = []
    
    func fetchClothes() {
        guard let url = URL(string: "https://raw.githubusercontent.com/OpenClassrooms-Student-Center/Cr-ez-une-interface-dynamique-et-accessible-avec-SwiftUI/main/api/clothes.json") else {
            print("Invalid URL")
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data returned")
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode([Clothes].self, from: data)
                DispatchQueue.main.async {
                    self.clothes = decodedData
                }
            } catch let decodingError {
                print("Error decoding data: \(decodingError)")
            }
        }.resume()
    }

}
