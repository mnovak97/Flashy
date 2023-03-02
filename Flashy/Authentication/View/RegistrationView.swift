//
//  RegistrationView.swift
//  Flashy
//
//  Created by Martin Novak on 21.12.2022..
//

import SwiftUI

struct RegistrationView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var email: String = ""
    @State private var optionSelected = "Package type"
    @EnvironmentObject var authViewModel : AuthViewModel
    var body: some View {
        VStack {
            Text("Sign Up")
                .fontWeight(.bold)
                .padding(.top, 100)
                .font(.custom("Futura-MediumItalic", fixedSize: 36))
            
            Spacer()
            CustomTextFieldRegister(title:"Email", placeholder: "Enter email", text: $email)
            CustomTextFieldRegister(title:"Username", placeholder: "Enter username", text: $username)
            CustomTextFieldRegister(isPassword: true, title:"Password",placeholder: "Enter password", text: $password)
            
            HStack {
                Text("Selected package")
                    .font(.title3)
                    .padding(.leading)
                Spacer()
                
                Menu {
                    Button {
                        optionSelected = "GOLD 14.99$ 500MB"
                    } label: {
                        Text("GOLD 14.99$ 15GB")
                    }
                    Button {
                        optionSelected = "PRO 9.99$ 250MB"
                    } label: {
                        Text("PRO 9.99$ 10GB")
                    }
                    Button {
                        optionSelected = "BASIC 4.99$ 100MB"
                    } label: {
                        Text("BASIC 4.99$ 500MB")
                    }
                } label: {
                    Text(optionSelected)
                        .foregroundColor(.gray)
                        .font(.title3)
                }
                Spacer()
            }
            
            Button {
                authViewModel.signUp(email: email,username: username, password: password, package: optionSelected)
            } label: {
                Text("Sign up")
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
            .padding(.top, 30)
           
            Spacer()
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
