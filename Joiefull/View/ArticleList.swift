//
//  ArticleList.swift
//  Joiefull
//
//  Created by Louise Ta on 25/10/2024.
//

import SwiftUI

struct ArticleList: View {
    @ObservedObject var viewModel: ArticleViewModel
    @Binding var selectedArticle: Article?
    
    var body: some View {
        List {
            ForEach(viewModel.categories.keys.sorted(), id: \.self) { key in
                ArticleListRow(
                    viewModel: viewModel,
                    categoryName: key,
                    article: viewModel.categories[key]!,
                    selectedArticle: $selectedArticle
                )
            }
        }.listStyle(.plain)
    }
}
