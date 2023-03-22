//
//  UsersThumbnail.swift
//  Flashy
//
//  Created by Martin Novak on 21.03.2023..
//

import SwiftUI

struct UsersThumbnail: View {
    @State var user : User
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "person.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25,height: 25)
                
                Text(user.username)
                Spacer()
            }
            .padding(.leading)
            HStack {
                Text(user.packageType)
                Spacer()
            }
            .padding(.leading)
            Divider()
        }
    }
}

struct UsersThumbnail_Previews: PreviewProvider {
    static var previews: some View {
        UsersThumbnail(user: User(documentID: "kajsdkadkansd", email: "mail@mail.com", password: "adadad", username: "username", consumptionMax: 15, packageType: "GOLD 14.99$ 50 Pictures", consumption: 12.5))
    }
}
