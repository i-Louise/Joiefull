//
//  ArticleListRow.swift
//  Joiefull
//
//  Created by Louise Ta on 23/09/2024.
//

import SwiftUI

struct ArticleListRow: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var categoryName: String
    var articles: [Article]
    
    @Binding var selectedArticle: Article?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(categoryName)
                .font(.headline)
                .padding(.leading, 15)
                .padding(.top, 5)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 0) {
                    ForEach(articles) { article in
                        if horizontalSizeClass == .compact {
                            NavigationLink {
                                LazyNavigationView(
                                    ArticleDetail(
                                        viewModel: ArticleDetailViewModel(
                                            article: article,
                                            reviewRepository: ReviewRepository(),
                                            viewContext: PersistenceController.shared.container.viewContext
                                        )
                                    )
                                )
                            } label: {
                                ArticleListRowItem(
                                    viewModel: ArticleListRowItemViewModel(
                                        article: article,
                                        reviewRepository: ReviewRepository(
                                            viewContext: PersistenceController.shared.container.viewContext
                                        )
                                    )
                                )
                            }
                        } else {
                            ArticleListRowItem(
                                viewModel: ArticleListRowItemViewModel(
                                    article: article,
                                    reviewRepository: ReviewRepository(
                                        viewContext: PersistenceController.shared.container.viewContext
                                    )
                                ))
                                .padding(2)
                                .background(selectedArticle?.id == article.id ? Color.blue.opacity(0.5) : Color.clear)
                                .cornerRadius(16)
                                .onTapGesture {
                                    print("selected \(article.name)")
                                    selectedArticle = article
                                }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    @State var selectedArticle: Article? = nil
    
    let testArticles = [
        Article(
            id: 0,
            name: "Sac rose",
            likes: 4,
            price: 80,
            originalPrice: 160,
            category: .accessoiries,
            picture: Article.Picture(
                url: "https://raw.githubusercontent.com/OpenClassrooms-Student-Center/Cr-ez-une-interface-dynamique-et-accessible-avec-SwiftUI/main/img/accessories/3.jpg",
                description: "c'est une photo"
            )
        )
    ]
    
    return ArticleListRow(
        categoryName: "Accessories",
        articles: testArticles,
        selectedArticle: $selectedArticle
    )
}
