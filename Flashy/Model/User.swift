//
//  User.swift
//  Flashy
//
//  Created by Martin Novak on 23.12.2022..
//

import Foundation
import FirebaseFirestoreSwift
import Firebase

class User: Identifiable, Decodable {
    @DocumentID var id: String?
    let email: String
    let password: String
    let username: String
    let packageMaxConsumption: Int
    let packageType: String
    var isAdmin: Bool? = false
    let consumption: Float
    
    
    init(documentID: String, email:String, password: String, username:String, consumptionMax: Int, packageType: String, consumption: Float) {
        self.id = documentID
        self.email = email
        self.password = password
        self.username = username
        self.packageMaxConsumption = consumptionMax
        self.packageType = packageType
        self.consumption = consumption
    }
}
