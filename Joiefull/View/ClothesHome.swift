//
//  CategoryList.swift
//  Joiefull
//
//  Created by Louise Ta on 26/09/2024.
//

import SwiftUI

struct ClothesHome: View {
    @StateObject var viewModel = ClothesViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(groupedClothes.keys.sorted(), id: \.self) { key in
                    if let items = groupedClothes[key] {
                        CategoryRow(categoryName: key, items: items)
                    }
                }
            }
            .listStyle(.plain)
            .onAppear {
                viewModel.fetchClothes()
            }
        }
    }
    private var groupedClothes: [String: [Clothes]] {
        Dictionary(grouping: viewModel.clothes) { $0.category.rawValue }
    }
}

#Preview {
    ClothesHome()
}
