//
//  NetworkServiceMock.swift
//  JoiefullTests
//
//  Created by Louise Ta on 01/11/2024.
//

import Foundation
@testable import Joiefull

class NetworkServiceMock: NetworkServicing {
    var shouldFail = false
    
    func getAllArticles() async throws -> [Article] {
        if shouldFail {
            throw NSError(domain: "", code: -1, userInfo: nil)
        }
        return [Article(id: 0,
                        name: "Sac à main orange posé sur une poignée de porte",
                        likes: 40,
                        price: 50,
                        originalPrice: 60,
                        category: Article.Category.accessoiries,
                        picture: Article.Picture(url: "https://raw.githubusercontent.com/OpenClassrooms-Student-Center/Cr-ez-une-interface-dynamique-et-accessible-avec-SwiftUI/main/img/accessories/1.jpg", description: "Sac à main orange posé sur une poignée de porte")
            ),
            Article(id: 1,
                    name: "Jean pour femme",
                    likes: 50,
                    price: 30,
                    originalPrice: 40,
                    category: Article.Category.bottoms,
                    picture: Article.Picture(url: "https://raw.githubusercontent.com/OpenClassrooms-Student-Center/Cr-ez-une-interface-dynamique-et-accessible-avec-SwiftUI/main/img/bottoms/1.jpg", description: "Modèle femme qui porte un jean et un haut jaune"))
        
        ]
    }
}


