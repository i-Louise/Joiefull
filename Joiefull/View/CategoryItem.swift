//
//  CategoryItem.swift
//  Joiefull
//
//  Created by Louise Ta on 23/09/2024.
//

import SwiftUI

struct CategoryItem: View {
    
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: "https://raw.githubusercontent.com/OpenClassrooms-Student-Center/Cr-ez-une-interface-dynamique-et-accessible-avec-SwiftUI/main/img/accessories/1.jpg")) { phase in
                
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
            .frame(width: 256, height: 256)
            .clipShape(.rect(cornerRadius: 25))
            
            VStack {
                HStack {
                    Text("Sac orange")
                    Spacer()
                    HStack(spacing: 2) {
                        Image(systemName: "star.fill")
                            .foregroundColor(.orange)
                        Text("4")
                            .foregroundColor(.gray)
                    }
                }
                HStack {
                    Text("89€")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.black)
                    Spacer()
                    Text("120€")
                        .strikethrough()
                        .foregroundColor(.gray)
                        .font(.system(size: 16))
                }
            }
        }
        .padding(.leading, 15)
    }
}

struct ItemTitle: View {
    var body: some View {
        VStack {
            VStack {
                Text("Sac orange")
                HStack(alignment: .center) {
                    Text("4")
                    Image(systemName: "star.fill")
                    
                    //Spacer()
                    
                    Text("120€")
                        .strikethrough()
                        .foregroundColor(.gray)
                        .font(.system(size: 16))
                    
                    Text("89€")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.black)
                }
            }
        }
    }
}

#Preview {
    CategoryItem()
}
