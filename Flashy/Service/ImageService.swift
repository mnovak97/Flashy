//
//  ImageService.swift
//  Flashy
//
//  Created by Martin Novak on 15.02.2023..
//

import Foundation
import Firebase
import FirebaseStorage

struct ImageService {
    let userService = UserService()
    func fetchPictures(completion:@escaping([Picture]) -> Void) {
        var pictures = [Picture]()
        Firestore.firestore().collection("pictures")
            .order(by: "date", descending: true)
            .addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
                pictures = documents.map({ (queryDocumentSnapshot) -> Picture in
                    let data = queryDocumentSnapshot.data()
                    let documentID = queryDocumentSnapshot.documentID
                    let date = (data["date"] as? Timestamp)?.dateValue() ?? Date()
                    let description = data["description"] as? String ?? ""
                    let author = data["author"] as? String ?? ""
                    let hashtags = data["hashtags"] as? String ?? ""
                    let picUrl = data["pictureUrl"] as? String ?? ""
                    let userID = data["userID"] as? String ?? ""
                    
                    return Picture(documentID: documentID, date: date, descritpion: description, author: author, hashtags: hashtags, imageUrl: picUrl, user: userID)
                })
                completion(pictures)
        }
    }
    
    func fetchImageForUser(userID: String, completion:@escaping([Picture]) -> Void) {
        var pictures = [Picture]()
        Firestore.firestore().collection("pictures")
            .whereField("userID", isEqualTo: userID)
            .addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
                pictures = documents.map({ (queryDocumentSnapshot) -> Picture in
                    let data = queryDocumentSnapshot.data()
                    let documentID = queryDocumentSnapshot.documentID
                    let date = (data["date"] as? Timestamp)?.dateValue() ?? Date()
                    let description = data["description"] as? String ?? ""
                    let author = data["author"] as? String ?? ""
                    let hashtags = data["hashtags"] as? String ?? ""
                    let picUrl = data["pictureUrl"] as? String ?? ""
                    let userID = data["userID"] as? String ?? ""
                    
                    return Picture(documentID: documentID, date: date, descritpion: description, author: author, hashtags: hashtags, imageUrl: picUrl, user: userID)
                })
                completion(pictures)    
        }
    }
    
    func fetchTotalImageSizeForUser(userID: String, completion:@escaping (Int) -> Void) {
        
    }
}
