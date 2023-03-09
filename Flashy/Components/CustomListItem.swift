//
//  CustomListItem.swift
//  Flashy
//
//  Created by Martin Novak on 03.03.2023..
//

import SwiftUI

struct CustomListItem: View {
    var imageName:String
    var text:String
    var body: some View {
        HStack {
            Image(systemName: imageName)
                .foregroundColor(Color(.systemBlue))
            Text(text)
                .font(.title2)
            
            Spacer()
            Image(systemName: "control")
                .rotationEffect(.degrees(90.0))
                .foregroundColor(Color(.systemBlue))
        }
        .padding()
    }
}

struct CustomListItem_Previews: PreviewProvider {
    static var previews: some View {
        CustomListItem(imageName: "lock", text: "Change your password")
    }
}
