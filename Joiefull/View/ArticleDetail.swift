//
//  ArticleDetail.swift
//  Joiefull
//
//  Created by Louise Ta on 26/09/2024.
//

import SwiftUI

struct ArticleDetail: View {
    @ObservedObject var viewModel: ArticleDetailViewModel
    
    @State private var isShareSheetShowing = false
    
    var body: some View {
        GeometryReader { geometry in
            let frame = geometry.size
            ScrollView {
                VStack {
                    ZStack {
                        AsyncImage(url: URL(string: viewModel.article.picture.url)) { phase in
                            switch phase {
                            case .failure:
                                Image(systemName: "photo")
                                    .font(.largeTitle)
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .clipped()
                            default:
                                ProgressView()
                            }
                        }
                        .frame(width: frame.width - 30, height: frame.height * 0.6)
                        .clipShape(.rect(cornerRadius: 25))
                        .accessibilityHint(Text("\(viewModel.article.picture.description)"))
                        VStack {
                            if let url = URL(string: viewModel.article.picture.url) {
                                HStack {
                                    Spacer()
                                    Button(action: {
                                        isShareSheetShowing = true
                                    }) {
                                        Image("ShareIcon")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 25)
                                            .padding(10)
                                            .background(Color.white.opacity(0.8))
                                            .clipShape(.rect(cornerRadius: 20))
                                            .shadow(radius: 4)
                                            .padding()
                                    }
                                    .sheet(isPresented: $isShareSheetShowing, content: {
                                        ActivityViewController(activityItems: [viewModel.article.name, url])
                                    })
                                }
                            }
                        
                            Spacer()
                            HStack {
                                Spacer()
                                LikesView(like: viewModel.like)
                                    .padding(6)
                                    .background(Color.white.opacity(0.8))
                                    .cornerRadius(16)
                                    .shadow(radius: 4)
                                    .padding()
                            }
                        }
                    }
                    VStack(alignment: .leading) {
                        HStack {
                            Text(viewModel.article.name)
                                .foregroundStyle(Color.primary)
                                .font(.title3)
                                .bold()
                            Spacer()
                            HStack(spacing: 2) {
                                Image(systemName: "star.fill")
                                    .font(.title3)
                                    .foregroundColor(.orange)
                                Text(getHumanReadableRating())
                                    .foregroundColor(.black)
                                    .font(.title3)
                            }
                        }
                        HStack {
                            Text("\(String(format: "%.2f", viewModel.article.price))€")
                                .font(.title3)
                                .foregroundColor( .black)
                            Spacer()
                            Text("\(String(format: "%.2f", viewModel.article.originalPrice))€")
                                .strikethrough()
                                .foregroundColor(.gray)
                                .font(.title3)
                        }
                            HStack {
                                Image(systemName: "person.circle")
                                    .font(.title)
                                RatingView(rating: $viewModel.userRating)
                                    .padding(4)
                                Spacer()
                            }
                            Text("Partagez ici vos impressions sur cette pièce")
                                .font(.subheadline)
                                .foregroundStyle(Color.secondary)
                            
                            TextEditor(text: $viewModel.userComment)
                                .foregroundStyle(.secondary)
                                .frame(height: frame.height / 8)
                                .padding(.horizontal)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.gray, lineWidth: 1)
                                )
                            Button(action: {
                                viewModel.addReview()
                                viewModel.updateAverageRating()
                            }) {
                                Text("Send")
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.orange)
                                    .foregroundColor(.white)
                                    .cornerRadius(30)
                            }
                    }
                }
                .padding(15)
            }.accessibilityLabel("Detail page with more details about the item")
        }
    }
    
    private func getHumanReadableRating() -> String {
        guard let rating = viewModel.averageRating else {
            return "No rating"
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
        picture: Article.Picture(
            url: "https://raw.githubusercontent.com/OpenClassrooms-Student-Center/Cr-ez-une-interface-dynamique-et-accessible-avec-SwiftUI/main/img/accessories/2.jpg",
            description: "A casual t-shirt"
        )
    )
    return ArticleDetail(
        viewModel: ArticleDetailViewModel(
            article: testArticle,
            like: Like(likes: 42, isLiked: false),
            reviewRepository: ReviewRepository(
                viewContext: PersistenceController().container.viewContext
            )
        )
    )
}
