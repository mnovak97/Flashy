//
//  AdminViewModel.swift
//  Flashy
//
//  Created by Martin Novak on 21.03.2023..
//

import Foundation

class AdminViewModel : ObservableObject {
    @Published var users = [User]()
    @Published var searchText = ""
    let userService = UserService()
    
    var searchableUsers : [User] {
        if searchText.isEmpty {
            return users
        } else {
            let lowercasedQuery = searchText.lowercased()
            return users.filter { $0.username.contains(lowercasedQuery)}
        }
    }
    
    init() {
        self.fetchUsers()
    }
    
    func fetchUsers() {
        self.userService.fetchUsers { users in
            self.users = users
        }
    }
}
