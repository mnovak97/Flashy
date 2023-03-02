//
//  ProfileViewModel.swift
//  Flashy
//
//  Created by Martin Novak on 16.02.2023..
//

import Foundation
import Firebase

class ProfileViewModel: ObservableObject {
    @Published var totalUsage = 0
    @Published var packageMaxConsumption = 0
    let imageService = ImageService()
    let user: User
    
    init(user: User) {
        self.user = user
        self.fetchTotalUsage()
        self.getMaxConsumption()
    }
    
    func fetchTotalUsage() {
        if let userID = user.id {
            self.imageService.fetchUserImageUrls(userID: userID) { urls in
                for url in urls {
                    self.imageService.fetchImageSize(imageUrl: url) { size in
                        self.totalUsage += size / 1000
                    }
                }
            }
        }
    }
    
    func getMaxConsumption() {
        if let package = user.packageType.components(separatedBy: " ").first {
            if package == "GOLD" {
                self.packageMaxConsumption = 50000
            } else if package == "PRO" {
                self.packageMaxConsumption = 25000
            } else if package == "BASIC" {
                self.packageMaxConsumption = 10000
            }
        }
    }
}
