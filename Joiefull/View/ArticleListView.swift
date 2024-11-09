//
//  ArticleList.swift
//  Joiefull
//
//  Created by Louise Ta on 25/10/2024.
//

import SwiftUI

struct ArticleListView: View {
    @ObservedObject var viewModel: ArticleListViewModel
    @Binding var selectedArticle: Article?
    
    var body: some View {
        List {
            ForEach(viewModel.categories.elements, id: \.key) { category, articles in
                ArticleListRowView(
                    articleListViewModel: viewModel,
                    categoryName: category,
                    articles: articles,
                    selectedArticle: $selectedArticle
                )
            }
        }
        .listStyle(.plain)
        .onAppear {
            viewModel.fetchArticles {}
        }
    }
}

#Preview {
    @Previewable @State var selectedArticle: Article? = nil
    
    return ArticleListView(
        viewModel: ArticleListViewModel(
            networkService: NetworkService(),
            articleRepository: ArticleRepository(),
            reviewRepository: ReviewRepository(
                viewContext: PersistenceController().container.viewContext
            ),
            likeRepository: LikeRepository()
        ),
        selectedArticle: $selectedArticle
    )
}
