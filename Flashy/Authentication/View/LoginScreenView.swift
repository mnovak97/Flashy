//
//  LoginScreenView.swift
//  Flashy
//
//  Created by Martin Novak on 21.12.2022..
//

import SwiftUI

struct LoginScreenView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @EnvironmentObject var authViewModel: AuthViewModel
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                
                Text("Flashy")
                    .fontWeight(.bold)
                    .padding(.top, 100)
                    .font(.custom("Futura-MediumItalic", fixedSize: 64))
                
               Spacer()
                    
                
                    
                //MARK: - Login info
                VStack(spacing: 30) {
                    CustomTextField(isPassword: false, imageName: "person.circle", placeHolder: "Username", text: $email)
                    
                    CustomTextField(isPassword: true, imageName: "lock", placeHolder: "Password", text: $password)
                }
                .padding(.horizontal, 32)
                
                HStack {
                   
                    Spacer()
                    NavigationLink {
                        
                    } label: {
                        Text("Continue anonymous")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(Color(.systemBlue))
                            .padding(.trailing, 30)
                    }
                }
                Spacer()
                
                Button {
                    authViewModel.loginWithEmailAndPassword(email: email, password: password)
                } label: {
                    Text("Sign in")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(maxWidth:.infinity)
                        .padding()
                        .background(Color(.systemBlue))
                        .cornerRadius(50)
                        .shadow(color: Color.black.opacity(0.4), radius: 10, x:0.0, y:2)
                        .padding(.horizontal, 20)
                }

                Button {
                    print("Signing in with github")
                } label: {
                    CustomSignInButton(imageType: ImageType.systemImage, imageName: "apple.logo", placeholder: "Sign in with Apple ID")
                        .padding(.horizontal, 20)
                }
                
                Button {
                    authViewModel.signInWithGoogle()
                } label: {
                    CustomSignInButton(imageType: ImageType.assetImage, imageName: "googleLogo", placeholder: "Sign in with Google")
                        .padding(.horizontal, 20)
                }
                Spacer()
                
                NavigationLink {
                    RegistrationView()
                        .navigationBarHidden(true)
                } label: {
                    HStack {
                        Text("Don't have an account?")
                            .font(.subheadline)
                        
                        Text("Sign Up")
                            .font(.subheadline)
                            .fontWeight(.bold)
                    }
                    .foregroundColor(Color(.systemBlue))
                }

            }
        }
        .navigationBarHidden(true)
    }
}

struct LoginScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreenView()
    }
}
