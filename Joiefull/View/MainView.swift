//
//  MainView.swift
//  Joiefull
//
//  Created by Louise Ta on 26/09/2024.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel: ArticleViewModel
    @State private var selectedArticle: Article?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        NavigationStack {
            HStack {
                ArticleList(viewModel: viewModel, selectedArticle: $selectedArticle)
                if horizontalSizeClass == .regular {
                    ArticleDetailSideView(selectedArticle: $selectedArticle, viewModel: viewModel)
                }
            }.onAppear {
                viewModel.fetchArticles()
            }
        }.accessibilityLabel("Home page with all the catalogue")
    }
}

private struct ArticleDetailSideView: View {
    @Binding var selectedArticle: Article?
    var viewModel: ArticleViewModel
    
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
                ArticleDetail(article: article, viewModel: viewModel)
            }
            .frame(maxWidth: UIScreen.main.bounds.width / 3)
            .transition(.slide)
            .padding()
        }
    }
}

#Preview {
    let context = PersistenceController.preview.container.viewContext
    let viewModel = ArticleViewModel(context: context)
    return MainView(viewModel: viewModel)
}