//
//  ImageUploadViewModel.swift
//  Flashy
//
//  Created by Martin Novak on 30.12.2022..
//

import Foundation
import SwiftUI
import Firebase
import FirebaseAuth

class ImageUploadViewModel: ObservableObject {
    
    func uploadPicture(_ image: UIImage,description : String, author: String, hashtags: String) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        ImageUploader.uploadImage(image: image) { pictureUrl in
            let pictureData = [ "date" : Timestamp(date: Date()),
                            "description" : description,
                            "author" : author,
                            "hashtags" : hashtags,
                            "pictureUrl" : pictureUrl,
                            "userID" : uid]
            let db = Firestore.firestore()
            let newPictureRef = db.collection("pictures").document()
            
            newPictureRef.setData(pictureData) {_ in
                print("Data set")
            }
            
        }
    }
}
