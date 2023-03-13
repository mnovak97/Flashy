//
//  CustomSignInButton.swift
//  Flashy
//
//  Created by Martin Novak on 21.12.2022..
//

import SwiftUI

struct CustomSignInButton: View {
    var imageType: ImageType
    var imageName: String
    var placeholder: String
    var body: some View {
        HStack {
            switch imageType {
            case .systemImage:
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20,height: 20)
                    .padding(.horizontal)
                    .foregroundColor(.black)
            case .assetImage:
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20,height: 20)
                    .padding(.horizontal)
            }
            Spacer()
            
            Text(placeholder)
                .font(.headline)
                .foregroundColor(.black)
            
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(50.0)
        .shadow(color: Color.black.opacity(0.4), radius: 10, x:0.0, y:2)

    }
}

struct CustomSignInButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomSignInButton(imageType: ImageType.systemImage, imageName: "apple.logo", placeholder: "Sign in with Apple")
    }
}
