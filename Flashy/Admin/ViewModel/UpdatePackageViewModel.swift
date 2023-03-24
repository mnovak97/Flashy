//
//  UpdatePackageViewModel.swift
//  Flashy
//
//  Created by Martin Novak on 24.03.2023..
//

import Foundation
class UpdatePackageViewModel : ObservableObject {
    let userService = UserService()
    
    func updatePackagePlan(uid: String, packagePlan: String, consumption: Int) {
        self.userService.updatePackagePlan(withUid: uid, packagePlan: packagePlan, consumption:consumption)
    }
}
