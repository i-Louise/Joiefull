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
    @Binding var selectedClothes: Clothes?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(categoryName)
                .font(.headline)
                .padding(.leading, 15)
                .padding(.top, 5)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 0) {
                    ForEach(items) { clothes in
                        if horizontalSizeClass == .compact {
                            NavigationLink {
                                ClothesDetail(clothes: clothes)
                            } label: {
                                CategoryItem(clothes: clothes)
                            }
                        } else {
                            CategoryItem(clothes: clothes)
                                .padding(2)
                                .background(selectedClothes?.id == clothes.id ? Color.blue.opacity(0.5) : Color.clear)
                                .cornerRadius(16)
                                .onTapGesture {
                                    print("selected\(clothes.name)")
                                    selectedClothes = clothes
                                }
                                
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    let url = "https://raw.githubusercontent.com/OpenClassrooms-Student-Center/Cr-ez-une-interface-dynamique-et-accessible-avec-SwiftUI/main/img/accessories/3.jpg"
    
    let testClothes = [
        Clothes(id: 0, name: "Sac rose", likes: 4, price: 80, original_price: 160, category: .accessoiries, picture: Clothes.Picture(url: url, description: "c'est une photo"))
    ]
    @State var selectedClothes: Clothes? = nil
    
    return CategoryRow(
        categoryName: "Accessories",
        items: testClothes, selectedClothes: $selectedClothes
    )
}
