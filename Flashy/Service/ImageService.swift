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
    
    func fetchUserImageUrls(userID: String, completion:@escaping([String]) -> Void) {
        var pictureUrls = [String]()
        let db = Firestore.firestore()
        let picturesRef = db.collection("pictures")
        let query = picturesRef.whereField("userID", isEqualTo: userID)
        query.getDocuments { snapshot, error in
            if let error = error {
                print("Error getting documents: \(error.localizedDescription)")
                return
            }
            for document in snapshot!.documents {
                let data = document.data()
                pictureUrls.append(data["pictureUrl"] as? String ?? "")
            }
            completion(pictureUrls)
        }
    }
    
    func fetchImageSize(imageUrl: String, completion:@escaping(Int) -> Void) {
        let storageRef = Storage.storage().reference(forURL: imageUrl)
        storageRef.getMetadata { metadata, error in
            if let error = error {
                print("Error getting metadata: \(error.localizedDescription)")
                return
            }
            if let size = metadata?.size {
                completion(Int(size))
            } else {
                print("Error getting file size")
            }
        }
    }
    
}
