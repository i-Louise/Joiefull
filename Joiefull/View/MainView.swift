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
    
    var body: some View {
        NavigationStack {
            HStack {
                ArticleList(
                    viewModel: ArticleListViewModel(
                        articleRepository: ArticleRepository(),
                        context: PersistenceController.shared.container.viewContext
                    ),
                    selectedArticle: $selectedArticle
                )
                if horizontalSizeClass == .regular {
                    ArticleDetailSideView(selectedArticle: $selectedArticle)
                }
            }
        }.accessibilityLabel("Home page with all the catalogue")
    }
}

private struct ArticleDetailSideView: View {
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
                ArticleDetail(
                    article: article,
                    viewModel: ArticleDetailViewModel(
                        reviewRepository: ReviewRepository(),
                        viewContext: PersistenceController.shared.container.viewContext
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
    MainView()
}
