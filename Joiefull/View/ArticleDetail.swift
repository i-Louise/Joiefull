//
//  ArticleDetail.swift
//  Joiefull
//
//  Created by Louise Ta on 26/09/2024.
//

import SwiftUI

struct ArticleDetail: View {
    var article: Article
    @ObservedObject var viewModel: ArticleViewModel
    @State private var comment: String = ""
    @State private var isShareSheetShowing = false
    
    var body: some View {
        GeometryReader { geometry in
            let frame = geometry.size
            ScrollView {
                VStack {
                    ZStack {
                        AsyncImage(url: URL(string: article.picture.url)) { phase in
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
                        .accessibilityHint(Text("\(article.picture.description)"))
                        VStack {
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
                                    ActivityViewController(activityItems: [article.name, URL(string: article.picture.url)!])
                                })
                            }
                            Spacer()
                            HStack {
                                Spacer()
                                Button(action: {
                                    
                                }) {
                                    HStack(spacing: 4) {
                                        Image(systemName: article.isFavorite == true ? "heart.fill" : "heart")
                                            .font(.body)
                                            .foregroundColor(article.isFavorite == true ? .red : .black)
                                        Text("\(article.likes)")
                                            .font(.body)
                                    }
                                    .padding(6)
                                    .background(Color.white.opacity(0.8))
                                    .cornerRadius(16)
                                    .shadow(radius: 4)
                                    .padding()
                                }
                            }
                        }
                    }
                    VStack(alignment: .leading) {
                        HStack {
                            Text(article.name)
                                .foregroundStyle(Color.primary)
                                .font(.title3)
                                .bold()
                            Spacer()
                            HStack(spacing: 2) {
                                Image(systemName: "star.fill")
                                    .font(.title3)
                                    .foregroundColor(.orange)
                                Text("\(viewModel.rating)")
                                    .foregroundColor(.black)
                                    .font(.title3)
                            }
                        }
                        HStack {
                            Text("\(String(format: "%.2f", article.price))€")
                                .font(.title3)
                                .foregroundColor( .black)
                            Spacer()
                            Text("\(String(format: "%.2f", article.originalPrice))€")
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
                            
                            TextEditor(text: $viewModel.comment)
                                .foregroundStyle(.secondary)
                                .frame(height: frame.height / 8)
                                .padding(.horizontal)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.gray, lineWidth: 1)
                                )
                            Button(action: {
                                viewModel.addReview()
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
        picture: Article.Picture(url: "https://raw.githubusercontent.com/OpenClassrooms-Student-Center/Cr-ez-une-interface-dynamique-et-accessible-avec-SwiftUI/main/img/accessories/2.jpg",
                                 description: "A casual t-shirt")
    )
    return ArticleDetail(article: testArticle, viewModel: viewModel)
}