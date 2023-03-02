//
//  CustomTexFieldRegister.swift
//  Flashy
//
//  Created by Martin Novak on 21.12.2022..
//

import SwiftUI

struct CustomTextFieldRegister: View {
    var isPassword: Bool? = false
    let title: String
    let placeholder: String
    @Binding var text: String
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .font(.title3)
                Spacer()
            }
            .padding(.bottom)
            if isPassword == true {
                SecureField(placeholder, text: $text)
                    .font(.title3)
            } else {
                TextField(placeholder, text: $text)
                    .font(.title3)
            }
            Divider()
                .background(Color.black)
        }
        .padding()
    }
}

struct CustomTexFieldRegister_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextFieldRegister(isPassword: false, title: "Username", placeholder: "Enter username", text: .constant(""))
    }
}
