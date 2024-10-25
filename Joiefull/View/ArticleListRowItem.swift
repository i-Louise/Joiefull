//
//  CategoryItem.swift
//  Joiefull
//
//  Created by Louise Ta on 23/09/2024.
//

import SwiftUI

struct ArticleListRowItem: View {
    var article: Article
    @ObservedObject var viewModel: ArticleViewModel
    @State private var selectedArticle: Article?
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .bottomTrailing) {
                AsyncImage(url: URL(string: article.picture.url)) { phase in
                    switch phase {
                    case .failure:
                        Image(systemName: "photo")
                            .font(.largeTitle)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                    default:
                        ProgressView()
                    }
                }
                .frame(width: 200, height: 200)
                .clipShape(.rect(cornerRadius: 16))
                .accessibilityHint(Text("\(article.picture.description)"))
                
                HStack(spacing: 4) {
                    Image(systemName: "heart")
                        .font(.body)
                    Text("\(article.likes)")
                        .font(.body)
                }
                .padding(6)
                .background(Color.white)
                .cornerRadius(30)
                .padding([.bottom, .trailing], 8)
            }
            
            VStack {
                HStack {
                    Text(article.name)
                        .font(.body)
                        .foregroundStyle(.black)
                        .frame(width: 150, alignment: .leading)
                        .lineLimit(1)
                        .truncationMode(.tail)
                    Spacer()
                    HStack(spacing: 2) {
                        Image(systemName: "star.fill")
                            .foregroundColor(.orange)
                        Text("\(viewModel.rating)")
                            .foregroundColor(.gray)
                            .font(.body)
                        
                    }
                }
                HStack {
                    Text("\(String(format: "%.2f", article.price))€")
                        .font(.body)
                        .foregroundColor(.black)
                    Spacer()
                    Text("\(String(format: "%.2f", article.originalPrice))€")
                        .strikethrough()
                        .foregroundColor(.gray)
                        .font(.body)
                }
            }
        }

        .padding()
    }
}

#Preview {
    let context = PersistenceController.preview.container.viewContext
    let viewModel = ArticleViewModel(context: context)
    let testArticle = Article(
        id: 1,
        name: "Casual T-Shirt",
        likes: 10,
        price: 29.99,
        originalPrice: 39.99,
        category: .tops,
        picture: Article.Picture(url: "https://raw.githubusercontent.com/OpenClassrooms-Student-Center/Cr-ez-une-interface-dynamique-et-accessible-avec-SwiftUI/main/img/accessories/3.jpg",
            description: "A casual t-shirt")
    )
    @State var selectedArticle: Article?
    return ArticleListRowItem(article: testArticle, viewModel: viewModel)
}
