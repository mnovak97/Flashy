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
            self.imageService.fetchTotalImageSizeForUser(userID: userID) { usage in
                self.totalUsage = usage
            }
        }
    }
    
    func getMaxConsumption() {
        if let package = user.packageType.components(separatedBy: " ").first {
            if package == "GOLD" {
                self.packageMaxConsumption = 500000
            } else if package == "PRO" {
                self.packageMaxConsumption = 250000
            } else if package == "BASIC" {
                self.packageMaxConsumption = 100000
            }
        }
    }
}
