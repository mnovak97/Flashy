//
//  CustomTextField.swift
//  Flashy
//
//  Created by Martin Novak on 21.12.2022..
//

import SwiftUI

struct CustomTextField: View {
    let isPassword: Bool
    let imageName: String
    let placeHolder: String
    @Binding var text: String
    var body: some View {
        VStack {
            HStack {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25,height: 25)
                if isPassword {
                    SecureField(placeHolder, text: $text)
                        .font(.title3)
                } else {
                    TextField(placeHolder, text: $text)
                        .font(.title3)
                }
                
            }
            .frame(maxWidth: .infinity)
            Divider()
                .background(Color.black)
        }
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField(isPassword: true, imageName: "person.circle", placeHolder: "******", text: .constant(""))
    }
}
