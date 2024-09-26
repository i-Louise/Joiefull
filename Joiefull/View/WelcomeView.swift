//
//  WelcomeView.swift
//  Joiefull
//
//  Created by Louise Ta on 23/09/2024.
//

import SwiftUI

struct WelcomeView: View {
    var clothes: [Clothe] = [
        Clothe(id: 0, picture: Picture(url: "https://raw.githubusercontent.com/OpenClassrooms-Student-Center/Cr-ez-une-interface-dynamique-et-accessible-avec-SwiftUI/main/img/accessories/1.jpg", description: "Sac à main orange posé sur une poignée de porte"), name: "Sac à main orange", category: "ACCESSORIE", likes: 56, price: 69.99, original_price: 69.99),
        Clothe(id: 1, picture: Picture(url: "https://raw.githubusercontent.com/OpenClassrooms-Student-Center/Cr-ez-une-interface-dynamique-et-accessible-avec-SwiftUI/main/img/bottoms/1.jpg", description: "Modèle femme qui porte un jean et un haut jaune"), name: "Jean pour femme", category: "BOTTOMS", likes: 55, price: 49.99, original_price: 59.99),
        Clothe(id: 2, picture: Picture(url: "https://raw.githubusercontent.com/OpenClassrooms-Student-Center/Cr-ez-une-interface-dynamique-et-accessible-avec-SwiftUI/main/img/shoes/1.jpg", description: "Modèle femme qui pose dans la rue en bottes de pluie noires"), name: "Bottes noires pour l'automne", category: "SHOES", likes: 4, price: 99.99, original_price: 119.99),
        Clothe(id: 3, picture: Picture(url: "https://raw.githubusercontent.com/OpenClassrooms-Student-Center/Cr-ez-une-interface-dynamique-et-accessible-avec-SwiftUI/main/img/tops/1.jpg", description: "Homme en costume et veste de blazer qui regarde la caméra"), name: "Blazer marron", category: "TOPS", likes: 15, price: 79.99, original_price: 79.99)
    ]
    
    var body: some View {
        NavigationSplitView {
            List {
                ForEach(clothes, id: \.self) { clothe in
                    Text(clothe.name)
                }
            }
            .navigationTitle("Featured")
        } detail: {
            Text("Select a clothe")
        }
    }
}

#Preview {
    WelcomeView()
}
