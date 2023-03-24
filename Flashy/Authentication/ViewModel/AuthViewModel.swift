//
//  AuthViewModel.swift
//  Flashy
//
//  Created by Martin Novak on 22.12.2022..
//

import Firebase
import GoogleSignIn
import SwiftUI

class AuthViewModel : ObservableObject {
    @Published var userSession : FirebaseAuth.User?
    @Published var currentUser: User?
    @Published var userUpdated = false
    @Published var pictureUpdated = false
    
    
    private let service = UserService()
    
    init() {
        self.userSession = Auth.auth().currentUser
        self.fetchCurrentUser()
    }
    
    func loginWithEmailAndPassword(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Unable to login \(error.localizedDescription)")
            }
            guard let user = result?.user else {return}
            self.userSession = user
            self.fetchCurrentUser()
        }
    }
    
    func signInAnonymous() {
        Auth.auth().signInAnonymously { authResult, error in
            if let error = error {
                print("Unable to sign in anonymously \(error.localizedDescription)")
            }
            guard let user = authResult?.user else { return }
            self.userSession = user
        }
    }
    
    func signInWithGitHub() {
        let provider = OAuthProvider(providerID: "github.com")
        provider.getCredentialWith(nil) { credential, error in
            if error != nil {
                print("Error getting credentials")
                return
            }

            if let credential = credential {
                Auth.auth().signIn(with: credential) { authResult, error in
                    if error != nil {
                        print("Error signing in")
                        return
                    }
                    
                }
            }
        }
    }
    
    func signInWithGoogle() {
        
        if GIDSignIn.sharedInstance.hasPreviousSignIn() {
            GIDSignIn.sharedInstance.restorePreviousSignIn { [unowned self] user, error in
                authenticateUser(for: user, with: error)
            }
        } else {
            // 2
            guard let clientID = FirebaseApp.app()?.options.clientID else { return }
            
            // 3
            let configuration = GIDConfiguration(clientID: clientID)
            
            // 4
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
            guard let rootViewController = windowScene.windows.first?.rootViewController else { return }
            
            // 5
            GIDSignIn.sharedInstance.signIn(with: configuration, presenting: rootViewController) { [unowned self] user, error in
                authenticateUser(for: user, with: error)
            }
        }
    }
    func createUser(uid:String,email:String) {
        if let atIndex = email.firstIndex(of: "@") {
            let username = email.prefix(upTo: atIndex)
            let data = ["email": email,
                        "username": username,
                        "password":"",
                        "packageMaxConsumption": 10,
                        "packageType": "BASIC 4.99$ 10MB",
                        "isAdmin":false,
                        "consumption":0,
                        "uid": uid] as [String : Any]
            
            Firestore.firestore()
                .collection("users")
                .document(uid)
                .setData(data) {_ in
                    print("Data set")
                }
        }
    }
    
    func signUp(email: String,username: String, password: String, package: String,packageMaxConsumption:Int) {
        Auth.auth().createUser(withEmail: email, password: password) { result,error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let user = result?.user else { return }
            self.userSession = user
            
            let data  = ["email": email,
                         "username": username.lowercased(),
                         "password":password,
                         "packageMaxConsumption": packageMaxConsumption,
                         "packageType": package,
                         "isAdmin": false,
                         "consumption": 0,
                         "uid": user.uid]
            
            Firestore.firestore()
                .collection("users")
                .document(user.uid)
                .setData(data) {_ in
                    print("Data set")
                }
            self.fetchCurrentUser()
        }
    }
    
    private func authenticateUser(for user: GIDGoogleUser?, with error: Error?) {
      // 1
      if let error = error {
        print(error.localizedDescription)
        return
      }
      
      // 2
      guard let authentication = user?.authentication, let idToken = authentication.idToken else { return }
      
      let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)
      // 3
      Auth.auth().signIn(with: credential) { [unowned self] (authDataResult, error) in
        if let error = error {
            print(error.localizedDescription)
        } else {
            self.userSession = authDataResult?.user
            let uid = authDataResult?.user.uid
            let email = authDataResult?.user.email
            let docRef = Firestore.firestore().collection("users").document(uid!)

            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    self.fetchCurrentUser()
                } else {
                    self.createUser(uid: uid!,email: email!)
                    self.fetchCurrentUser()
                }
            }
        }
      }
    }

    func signOut() {
        GIDSignIn.sharedInstance.signOut()
        
        try? Auth.auth().signOut()
        userSession = nil
        currentUser = nil
        
    }
    
    func fetchCurrentUser() {
        guard let uid = self.userSession?.uid else { return }
        service.fetchCurrentUser(withUid: uid) { user in
            self.currentUser = user	
        }
    }
    
}

