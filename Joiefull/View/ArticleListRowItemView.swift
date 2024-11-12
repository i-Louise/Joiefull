//
//  ArticleListRowItem.swift
//  Joiefull
//
//  Created by Louise Ta on 23/09/2024.
//

import SwiftUI

struct ArticleListRowItemView: View {
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
                .accessibilityValue(Text("\(viewModel.article.picture.description)"))
                
                LikesView(like: viewModel.like)
                    .padding(6)
                    .accessibilityHidden(true)
            }
            
            VStack {
                HStack {
                    Text(viewModel.article.name)
                        .font(.body)
                        .foregroundStyle(Color.primary)
                        .frame(width: 150, alignment: .leading)
                        .lineLimit(1)
                        .truncationMode(.tail)
                    Spacer()
                    HStack(spacing: 2) {
                        Image(systemName: "star.fill")
                            .foregroundColor(.orange)
                        Text(getHumanReadableRating())
                            .foregroundStyle(Color.primary)
                            .font(.body)
                    }
                    .accessibilityElement(children: .ignore)
                    .accessibilityValue("\(getHumanReadableRating()) étoiles sur 5")
                }
                HStack {
                    Text("\(String(format: "%.2f", viewModel.article.price))€")
                        .font(.body)
                        .foregroundStyle(Color.secondary)
                    Spacer()
                    Text("\(String(format: "%.2f", viewModel.article.originalPrice))€")
                        .strikethrough()
                        .foregroundStyle(Color.secondary)
                        .font(.body)
                }
                .accessibilityElement(children: .ignore)
                .accessibilityLabel(Text("Prix de \(String(format: "%.2f", viewModel.article.price))€ et était de \(String(format: "%.2f", viewModel.article.originalPrice))€"))
            }
        }
        .padding()
        .accessibilityAddTraits(.allowsDirectInteraction)
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
        category: Article.Category.tops,
        picture: Article.Picture(url: "https://raw.githubusercontent.com/OpenClassrooms-Student-Center/Cr-ez-une-interface-dynamique-et-accessible-avec-SwiftUI/main/img/accessories/3.jpg",
            description: "A casual t-shirt")
    )
    return ArticleListRowItemView(
        viewModel: ArticleListRowItemViewModel(
            article: testArticle,
            like: Like(likes: 42, isLiked: false),
            reviewRepository: ReviewRepository(
                viewContext: PersistenceController().container.viewContext
            )
        )
    )
}
