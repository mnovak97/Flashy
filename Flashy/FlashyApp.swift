//
//  FlashyApp.swift
//  Flashy
//
//  Created by Martin Novak on 21.12.2022..
//

import SwiftUI
import FirebaseCore
import GoogleSignIn

@main
struct FlashyApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject var authVievModel = AuthViewModel()
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authVievModel)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()

        return true
    }
    private func applicatuion(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any]) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }
    
}
