//
//  CategoryRow.swift
//  Joiefull
//
//  Created by Louise Ta on 23/09/2024.
//

import SwiftUI

struct CategoryRow: View {
    var categoryName: String
    var items: [Clothes]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(categoryName)
                .font(.headline)
                .padding(.leading, 15)
                .padding(.top, 5)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 0) {
                    ForEach(items) { clothes in
                        NavigationLink {
                            Text("place holder")
                        } label: {
                            CategoryItem(clothes: clothes)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    // Création de données de test
    var url = "https://raw.githubusercontent.com/OpenClassrooms-Student-Center/Cr-ez-une-interface-dynamique-et-accessible-avec-SwiftUI/main/img/accessories/3.jpg"
    
    let testClothes = [
        Clothes(id: 0, name: "Sac rose", likes: 4, price: 80, original_price: 160, category: .accessoiries, picture: Clothes.Picture(url: url, description: "c'est une photo"))
    ]
    
    // Utilisation des données de test dans la prévisualisation
    return CategoryRow(
        categoryName: "Accessories",
        items: testClothes
    )
}
