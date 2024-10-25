//
//  ArticleList.swift
//  Joiefull
//
//  Created by Louise Ta on 25/10/2024.
//

import SwiftUI

struct ArticleList: View {
    @ObservedObject var viewModel: ArticleListViewModel
    @Binding var selectedArticle: Article?
    
    var body: some View {
        List {
            ForEach(viewModel.categories.keys.sorted(), id: \.self) { category in
                ArticleListRow(
                    categoryName: category,
                    articles: viewModel.categories[category]!,
                    selectedArticle: $selectedArticle
                )
            }
        }
        .listStyle(.plain)
        .onAppear {
            viewModel.fetchArticles()
        }
    }
}

#Preview {
    @State var selectedArticle: Article? = nil
    
    return ArticleList(
        viewModel: ArticleListViewModel(
            networkService: NetworkService(),
            articleRepository: ArticleRepository(),
            context: PersistenceController.shared.container.viewContext
        ),
        selectedArticle: $selectedArticle
    )
}
