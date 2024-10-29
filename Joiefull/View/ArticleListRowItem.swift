//
//  ArticleListRowItem.swift
//  Joiefull
//
//  Created by Louise Ta on 23/09/2024.
//

import SwiftUI

struct ArticleListRowItem: View {
    @ObservedObject var viewModel: ArticleListRowItemViewModel
        
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .bottomTrailing) {
                AsyncImage(url: URL(string: viewModel.article.picture.url)) { phase in
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
                .accessibilityHint(Text("\(viewModel.article.picture.description)"))
                
                HStack(spacing: 4) {
                    Image(systemName: "heart")
                        .font(.body)
                    Text("\(viewModel.article.likes)")
                        .font(.body)
                }
                .padding(6)
                .background(Color.white)
                .cornerRadius(30)
                .padding([.bottom, .trailing], 8)
            }
            
            VStack {
                HStack {
                    Text(viewModel.article.name)
                        .font(.body)
                        .foregroundStyle(.black)
                        .frame(width: 150, alignment: .leading)
                        .lineLimit(1)
                        .truncationMode(.tail)
                    Spacer()
                    HStack(spacing: 2) {
                        Image(systemName: "star.fill")
                            .foregroundColor(.orange)
                        Text(getHumanReadableRating())
                            .foregroundColor(.gray)
                            .font(.body)
                    }
                }
                HStack {
                    Text("\(String(format: "%.2f", viewModel.article.price))€")
                        .font(.body)
                        .foregroundColor(.black)
                    Spacer()
                    Text("\(String(format: "%.2f", viewModel.article.originalPrice))€")
                        .strikethrough()
                        .foregroundColor(.gray)
                        .font(.body)
                }
            }
        }
        .padding()
    }
    
    private func getHumanReadableRating() -> String {
        guard let rating = viewModel.averageRating else {
            return "-"
        }
        return String(format: "%.1f", rating)
    }
}

#Preview {
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
    return ArticleListRowItem(
        viewModel: ArticleListRowItemViewModel(
            article: testArticle,
            reviewRepository: ReviewRepository(
                viewContext: PersistenceController().container.viewContext
            )
        )
    )
}
