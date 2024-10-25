//
//  CategoryRow.swift
//  Joiefull
//
//  Created by Louise Ta on 23/09/2024.
//

import SwiftUI

struct ArticleListRow: View {
    @ObservedObject var viewModel: ArticleViewModel
    var categoryName: String
    var article: [Article]
    @Binding var selectedArticle: Article?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(categoryName)
                .font(.headline)
                .padding(.leading, 15)
                .padding(.top, 5)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 0) {
                    ForEach(article) { article in
                        if horizontalSizeClass == .compact {
                            NavigationLink {
                                ArticleDetail(article: article, viewModel: viewModel)
                            } label: {
                                ArticleListRowItem(article: article, viewModel: viewModel)
                            }
                        } else {
                            ArticleListRowItem(article: article, viewModel: viewModel)
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
    let context = PersistenceController.preview.container.viewContext
    let viewModel = ArticleViewModel(context: context)
    let url = "https://raw.githubusercontent.com/OpenClassrooms-Student-Center/Cr-ez-une-interface-dynamique-et-accessible-avec-SwiftUI/main/img/accessories/3.jpg"
    
    let testArticle = [
        Article(id: 0, name: "Sac rose", likes: 4, price: 80, originalPrice: 160, category: .accessoiries, picture: Article.Picture(url: url, description: "c'est une photo"))
    ]
    @State var selectedArticle: Article? = nil
    
    return ArticleListRow(
        viewModel: viewModel, categoryName: "Accessories",
        article: testArticle, selectedArticle: $selectedArticle
    )
}
