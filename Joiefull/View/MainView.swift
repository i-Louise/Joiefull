//
//  MainView.swift
//  Joiefull
//
//  Created by Louise Ta on 26/09/2024.
//

import SwiftUI

struct MainView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    @State private var selectedArticle: Article?
    
    private let articleListViewModel: ArticleListViewModel
    
    init(articleListViewModel: ArticleListViewModel) {
        self.articleListViewModel = articleListViewModel
    }
    
    var body: some View {
        NavigationStack {
            HStack {
                ArticleListView(
                    viewModel: articleListViewModel,
                    selectedArticle: $selectedArticle
                )
                if horizontalSizeClass == .regular {
                    ArticleDetailSideView(
                        articleListViewModel: articleListViewModel,
                        selectedArticle: $selectedArticle
                    )
                }
            }
        }.accessibilityLabel("Home page with all the catalogue")
    }
}

private struct ArticleDetailSideView: View {
    let articleListViewModel: ArticleListViewModel
    @Binding var selectedArticle: Article?
    
    var body: some View {
        if let article = selectedArticle {
            VStack {
                HStack {
                    Button(action: {
                        selectedArticle = nil
                    }) {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.blue)
                        Text("Back")
                            .foregroundColor(.blue)
                    }
                    Spacer()
                }
                ArticleDetailView(
                    viewModel: articleListViewModel.getArticleDetailViewModel(
                        article: article
                    )
                )
            }
            .frame(maxWidth: UIScreen.main.bounds.width / 3)
            .transition(.slide)
            .padding()
        }
    }
}

#Preview {
    MainView(
        articleListViewModel: ArticleListViewModel(
            articleRepository: ArticleRepository(),
            reviewRepository: ReviewRepository(
                viewContext: PersistenceController().container.viewContext
            ),
            likeRepository: LikeRepository()
        )
    )
}
