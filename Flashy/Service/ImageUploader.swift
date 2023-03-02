//
//  ImageUploader.swift
//  Flashy
//
//  Created by Martin Novak on 24.12.2022..
//

import UIKit
import Firebase
import FirebaseStorage

struct ImageUploader {
    static func uploadImage (image: UIImage, completion: @escaping (String) -> Void) {
        
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
        
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/pictures/\(filename)")
        
        ref.putData(imageData, metadata: nil) { _, error in
                    if let error = error {
                        print("DEBUG: Failed to upload image with error: \(error.localizedDescription)")
                        return
                    }
                    
                    ref.downloadURL { imageUrl, _ in
                        guard let imageUrl = imageUrl?.absoluteString else {return}
                        completion(imageUrl)
                    }
                }
    }
}
