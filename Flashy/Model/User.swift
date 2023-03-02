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
    let packageType: String
    var isAdmin: Bool? = false
    let consumption: Float
}
