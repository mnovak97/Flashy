//
//  ProfileEditViewModel.swift
//  Flashy
//
//  Created by Martin Novak on 20.03.2023..
//

import Foundation
class ProfileEditViewModel : ObservableObject {
    let userService = UserService()
    
    
    func updateEmail(uid: String, newEmail:String) {
        self.userService.updateUserEmail(withUid: uid, newEmail: newEmail)
    }
    
    func updatePackagePlan(uid: String, packagePlan: String, consumption: Int) {
        self.userService.updatePackagePlan(withUid: uid, packagePlan: packagePlan, consumption:consumption)
    }
}
