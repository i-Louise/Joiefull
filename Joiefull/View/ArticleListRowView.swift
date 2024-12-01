//
//  ArticleListRow.swift
//  Joiefull
//
//  Created by Louise Ta on 23/09/2024.
//

import SwiftUI

struct ArticleListRowView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var articleListViewModel: ArticleListViewModel
    
    var categoryName: String
    var articles: [Article]
    
    @Binding var selectedArticle: Article?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(categoryName)
                .font(.headline)
                .padding(.leading, 15)
                .padding(.top, 5)
                .accessibilityLabel("catégorie \(categoryName)")
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 0) {
                    ForEach(articles) { article in
                        if horizontalSizeClass == .compact {
                            NavigationLink {
                                LazyNavigationLink(
                                    ArticleDetailView(
                                        viewModel: articleListViewModel.getArticleDetailViewModel(
                                            article: article
                                        )
                                    )
                                )
                            } label: {
                                ArticleListRowItemView(
                                    viewModel: articleListViewModel.getArticleListRowItemViewModel(
                                        article: article
                                    )
                                )
                            }
                        } else {
                            ArticleListRowItemView(
                                viewModel: articleListViewModel.getArticleListRowItemViewModel(
                                    article: article
                                ))
                                .background(selectedArticle?.id == article.id ? Color.blue.opacity(0.5) : Color.clear)
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
    @Previewable @State var selectedArticle: Article? = nil
    
    let testArticles = [
        Article(
            id: 0,
            name: "Sac rose",
            likes: 4,
            price: 80,
            originalPrice: 160,
            category: Article.Category.accessoiries,
            picture: Article.Picture(
                url: "https://raw.githubusercontent.com/OpenClassrooms-Student-Center/Cr-ez-une-interface-dynamique-et-accessible-avec-SwiftUI/main/img/accessories/3.jpg",
                description: "c'est une photo"
            )
        )
    ]
    
    return ArticleListRowView(
        articleListViewModel: ArticleListViewModel(
            articleRepository: ArticleRepository(),
            reviewRepository: ReviewRepository(
                viewContext: PersistenceController().container.viewContext
            ),
            likeRepository: LikeRepository()
        ),
        categoryName: "Accessories",
        articles: testArticles,
        selectedArticle: $selectedArticle
    )
}
