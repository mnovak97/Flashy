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
        var users = [User]()
        Firestore.firestore().collection("users")
            .addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
                users = documents.map({ (queryDocumentSnapshot) -> User in
                    let data = queryDocumentSnapshot.data()
                    let documentID = queryDocumentSnapshot.documentID
                    let email = data["email"] as? String ?? ""
                    let isAdmin = data["isAdmin"] as? Bool ?? false
                    let packageConsumption = data["packageMaxConsumption"] as? Int ?? 0
                    let packageType = data["packageType"] as? String ?? ""
                    let password = data["password"] as? String ?? ""
                    let username = data["username"] as? String ?? ""
                    let consumption = data["consumption"] as? Float ?? 0.0
                    
                    return User(documentID: documentID, email: email, password: password, username: username, consumptionMax: packageConsumption, packageType: packageType, consumption: consumption)
                })
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
