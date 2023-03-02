//
//  UserService.swift
//  Flashy
//
//  Created by Martin Novak on 09.02.2023..
//

import Firebase
import FirebaseFirestoreSwift
import FirebaseStorage

struct UserService {
    func fetchCurrentUser(withUid uid: String,completion: @escaping(User) -> Void) {
        Firestore.firestore().collection("users")
            .document(uid)
            .getDocument{ snapshot, _ in
                guard let snapshot = snapshot else { return }
                
                guard let user = try? snapshot.data(as: User.self) else { return }
                
                completion(user)
            }
    }
    
    func fetchUsers(completion: @escaping([User]) -> Void) {
            Firestore.firestore().collection("users")
                .getDocuments { snapshot, _ in
                    guard let documents = snapshot?.documents else { return }
                    let users = documents.compactMap({try? $0.data(as: User.self) })
                    
                    completion(users)
            }
    }
    
    func fetchUser(withUid uid: String, completion: @escaping(User) -> Void) {
            Firestore.firestore().collection("users")
                .document(uid)
                .getDocument { snapshot, _ in
                    guard let snapshot = snapshot else { return }
                    
                    guard let user = try? snapshot.data(as: User.self) else { return }
                    
                    completion(user)
                   
            }
    }
    
    func updateUserConsumption(uid: String, pictureUrl: String) {
        let db = Firestore.firestore()
        let storage = FirebaseStorage.Storage.storage().reference(forURL: pictureUrl)
        storage.getMetadata { data, err in
            if let size = data?.size {
                let userRef = db.collection("users")
                    .whereField("uid", isEqualTo: uid)
                    .getDocuments { result, err in
                        if err == nil {
                            for document in result?.documents {
                                var current = document.reference.value(forKey: "consumption")
                                var new = current + size
                                document.reference.setValue(new, forKey: "consumption")
                            }
                        }
                    }
            }
        }
    }
    
}
