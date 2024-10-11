//
//  UserRepository.swift
//  Joiefull
//
//  Created by Louise Ta on 11/10/2024.
//

import Foundation
import CoreData

struct UserRepository: UserRepositoryProtocol {
    let viewContext: NSManagedObjectContext
    init(viewContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.viewContext = viewContext
    }
    func getUser() throws -> User {
        let request = User.fetchRequest()
        request.fetchLimit = 1
        if let user = try viewContext.fetch(request).first {
            return user
        } else {
            let newUser = User(context: viewContext)
            newUser.firstName = "Unknown"
            newUser.lastName = "user"
            try viewContext.save()
            return newUser
        }
    }
}

protocol UserRepositoryProtocol {
    func getUser() throws -> User
}
