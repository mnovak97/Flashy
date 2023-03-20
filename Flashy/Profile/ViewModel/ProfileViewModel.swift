//
//  ProfileViewModel.swift
//  Flashy
//
//  Created by Martin Novak on 16.02.2023..
//

import Foundation
import Firebase
import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var totalUsage = 0
    @Published var user: User?
    var userID: String
    let imageService = ImageService()
    let userService = UserService()
    
    init() {
        self.userID = Auth.auth().currentUser!.uid
        self.getUser()
    }
    
    func getUser() {
        self.userService.fetchUser(withUid: userID) { user in
            self.user = user
        }
    }
    
    func fetchTotalUsage() {
        totalUsage = 0
        self.imageService.fetchUserImageUrls(userID: userID) { urls in
            for url in urls {
                self.imageService.fetchImageSize(imageUrl: url) { size in
                    self.totalUsage += 1
                }
            }
        }
    }
    
}
