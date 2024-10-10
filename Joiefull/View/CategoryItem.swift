//
//  CategoryItem.swift
//  Joiefull
//
//  Created by Louise Ta on 23/09/2024.
//

import SwiftUI

struct CategoryItem: View {
    var clothes: Clothes
    @State private var selectedClothes: Clothes?
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .bottomTrailing) {
                AsyncImage(url: URL(string: clothes.picture.url)) { phase in
                    
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
                
                HStack(spacing: 4) {
                    Image(systemName: "heart")
                        .font(.system(size: 14))
                    Text("\(clothes.likes)")
                        .font(.system(size: 14))
                }
                .padding(6)
                .background(Color.white)
                .cornerRadius(30)
                .padding([.bottom, .trailing], 8)
            }
            
            VStack {
                HStack {
                    Text(clothes.name)
                        .font(.system(size: 14))
                        .foregroundStyle(.black)
                        .frame(width: 150, alignment: .leading)
                        .lineLimit(1)
                        .truncationMode(.tail)
                    Spacer()
                    HStack(spacing: 2) {
                        Image(systemName: "star.fill")
                            .foregroundColor(.orange)
                        Text("4")
                            .foregroundColor(.gray)
                            .font(.system(size: 14))

                    }
                }
                HStack {
                    Text("\(String(format: "%.2f", clothes.price))€")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.black)
                    Spacer()
                    Text("\(String(format: "%.2f", clothes.original_price))€")
                        .strikethrough()
                        .foregroundColor(.gray)
                        .font(.system(size: 14))
                }
            }
        }
        .padding()
        
    }
}

#Preview {
    let testClothes = Clothes(
        id: 1,
        name: "Casual T-Shirt",
        likes: 10,
        price: 29.99,
        original_price: 39.99,
        category: .tops,
        picture: Clothes.Picture(url: "https://raw.githubusercontent.com/OpenClassrooms-Student-Center/Cr-ez-une-interface-dynamique-et-accessible-avec-SwiftUI/main/img/accessories/3.jpg",
            description: "A casual t-shirt")
    )
    @State var selectedClothes: Clothes?
    return CategoryItem(clothes: testClothes)
}
