//
//  UpdatePackageView.swift
//  Flashy
//
//  Created by Martin Novak on 21.03.2023..
//

import SwiftUI

struct UpdatePackageView: View {
    var user : User
    @State private var selectedPackage: String = ""
    var body: some View {
        VStack(alignment: .leading) {
            Text("Choose new package type")
                .font(.title3)
            HStack {
                Image(systemName: "externaldrive.badge.person.crop")
                Menu {
                    Button {
                        selectedPackage = "GOLD 14.99$ 50 Pictures"
                    } label: {
                        Text("GOLD 14.99$ 50 Pictures")
                    }
                    Button {
                        selectedPackage = "PRO 9.99$ 25 Pictures"
                    } label: {
                        Text("PRO 9.99$ 25 Pictures")
                    }
                    Button {
                        selectedPackage = "BASIC 4.99$ 10 Pictures"
                    } label: {
                        Text("BASIC 4.99$ 10 Pictures")
                    }
                } label: {
                    if selectedPackage == "" {
                        Text(user.packageType)
                            .foregroundColor(.gray)
                            .font(.title3)
                    } else {
                        Text(selectedPackage)
                            .foregroundColor(.gray)
                            .font(.title3)
                    }
                }
            }
            Divider()
            HStack {
                Spacer()
                Button {
                    print(user.id)
                } label: {
                    Text("Update")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(maxWidth:.infinity)
                        .padding()
                        .background(Color(.systemBlue))
                        .cornerRadius(50)
                        .shadow(color: Color.black.opacity(0.4), radius: 10, x:0.0, y:2)
                        .padding(.top,20)
                }
                Spacer()
            }
        }
        .padding(32)
    }
}

struct UpdatePackageView_Previews: PreviewProvider {
    static var previews: some View {
        UpdatePackageView(user: User(documentID: "kajsdkadkansd", email: "mail@mail.com", password: "adadad", username: "username", consumptionMax: 15, packageType: "GOLD 14.99$ 50 Pictures", consumption: 12.5))
    }
}
