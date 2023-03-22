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
    
    func fetchUserMaxConsumption(withUid uid: String, completion: @escaping(Int) -> Void) {
        Firestore.firestore().collection("users")
            .document(uid)
            .getDocument { snapshot, _ in
                guard let snapshot = snapshot else { return }
                guard let user = try? snapshot.data(as: User.self) else { return }
                completion(user.packageMaxConsumption)
            }
    }
    func updateUserPassword(withUid uid: String, newPassword: String) {
        let curretnUser = Auth.auth().currentUser
        curretnUser?.updatePassword(to: newPassword) { error in
            if let error = error {
                print("Error occured: \(error.localizedDescription)")
            } else {
                print("Password was changed")
            }
        }
        
        let docRef = Firestore.firestore().collection("users").document(uid)
        docRef.getDocument { querySnapshot, error in
            if let error = error {
                print("Error getting document: \(error.localizedDescription)")
            } else if (querySnapshot?.exists) != nil {
                docRef.updateData(["password": newPassword]) { (error) in
                    if let error = error {
                        print("Error updating document: \(error.localizedDescription)")
                    } else {
                        print("Document updated successfully.")
                    }
                }
            } else {
                print("No matching documents found.")
            }
        }
    }
    
    
    func updateUserEmail(withUid uid: String,newEmail:String) {
        let currentUser = Auth.auth().currentUser
        currentUser?.updateEmail(to: newEmail) { error in
            if let error = error {
                print("Error updating email: \(error.localizedDescription)")
            } else {
                print("Changed email")
            }
        }
        
        let docRef = Firestore.firestore().collection("users").document(uid)
        docRef.getDocument { querySnapshot, error in
            if let error = error {
                print("Error getting documents: \(error.localizedDescription)")
            } else if (querySnapshot?.exists) != nil {
                docRef.updateData(["email": newEmail]) { (error) in
                    if let error = error {
                        print("Error updating document: \(error.localizedDescription)")
                    } else {
                        print("Document updated successfully.")
                    }
                }
            } else {
                print("No matching documents found.")
            }
        }
    }
    
    func updatePackagePlan(withUid uid: String, packagePlan: String, consumption: Int) {
        let docRef = Firestore.firestore().collection("users").document(uid)
        docRef.getDocument { querySnapshot, error in
            if let error = error {
                print("Error getting documents: \(error.localizedDescription)")
            } else if (querySnapshot?.exists) != nil {
                docRef.updateData(["packageType": packagePlan,"packageMaxConsumption":consumption]) { (error) in
                    if let error = error {
                        print("Error updating document: \(error.localizedDescription)")
                    } else {
                        print("Document updated successfully.")
                    }
                }
            } else {
                print("No matching documents found.")
            }
        }
    }
        
}
