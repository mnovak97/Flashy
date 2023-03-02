//
//  Picture.swift
//  Flashy
//
//  Created by Martin Novak on 23.12.2022..
//

import Foundation
import FirebaseFirestoreSwift
import Firebase

class Picture: Identifiable,Decodable {
    @DocumentID var id: String?
    let date: Date
    let description: String
    let author: String
    let hashtags: String
    let imageUrl: String
    var userID: String
    
    var dateString : String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, dd 'of' MMMM"
        return formatter.string(from: date)
    }
    var user:User?
    
    init(documentID: String,date: Date,descritpion: String,author: String, hashtags: String, imageUrl:String, user: String) {
        self.id = documentID
        self.date = date
        self.description = descritpion
        self.author = author
        self.hashtags = hashtags
        self.imageUrl = imageUrl
        self.userID = user
    }
}
