//
//  CategoryList.swift
//  Joiefull
//
//  Created by Louise Ta on 26/09/2024.
//

import SwiftUI

struct ClothesHome: View {
    @StateObject var viewModel = ClothesViewModel()
    @State private var selectedClothes: Clothes?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    
    var body: some View {
        NavigationStack {
            HStack {
                ClothesList(viewModel: viewModel, selectedClothes: $selectedClothes)
                if horizontalSizeClass == .regular {
                    if let clothes = selectedClothes {
                        Group {
                            VStack {
                                HStack {
                                    Button(action: {
                                        withAnimation {
                                            selectedClothes = nil
                                        }
                                    }) {
                                        Image(systemName: "arrow.left")
                                            .foregroundColor(.blue)
                                        Text("Back")
                                            .foregroundColor(.blue)
                                    }
                                    Spacer()
                                }
                                ClothesDetail(clothes: clothes)
                            }
                            .frame(maxWidth: UIScreen.main.bounds.width / 3)
                            .transition(.slide)
                            .padding()
                        }
                    }
                }
            }.onAppear {
                viewModel.fetchClothes()
        }
        }.accessibilityLabel("Home page with all the catalogue")
    }
}

struct ClothesList: View {
    @ObservedObject var viewModel: ClothesViewModel
    @Binding var selectedClothes: Clothes?
    
    var body: some View {
        List {
            ForEach(viewModel.categories.keys.sorted(), id: \.self) { key in
                CategoryRow(categoryName: key, items: viewModel.categories[key]!, selectedClothes: $selectedClothes)
                
            }
        }.listStyle(.plain)
    }
}

#Preview {
   ClothesHome()
}
