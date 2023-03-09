//
//  ProfileEditView.swift
//  Flashy
//
//  Created by Martin Novak on 03.03.2023..
//

import SwiftUI

struct ProfileEditView: View {
    let editType:ProfileEdit
    @State private var text: String = ""
    @State private var oldPassword: String = ""
    @State private var selectedPackage: String = ""
    @EnvironmentObject var authVM : AuthViewModel
    var body: some View {
        switch editType {
        case .password:
            VStack (alignment:.leading) {
                HStack {
                    Image(systemName: "lock")
                    TextField("Enter current password", text: $oldPassword)
                }
                Divider()
                Text("New password")
                    .font(.title3)
                HStack {
                    Image(systemName: "lock")
                    TextField("Enter new password", text: $text)
                }
                Divider()
                
                HStack {
                    Spacer()
                    Button {
                        print("Updated ")
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
        case .email:
            VStack(alignment:.leading) {
                Text("New mail")
                    .font(.title3)
                HStack {
                    Image(systemName:"envelope")
                    TextField("Enter new e-mail", text: $text)
                }
                Divider()
                HStack {
                    Spacer()
                    Button {
                        print("Updated ")
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
        case .packageType:
            VStack(alignment: .leading) {
                Text("Choose new package type")
                    .font(.title3)
                HStack {
                    Image(systemName: "externaldrive.badge.person.crop")
                    Menu {
                        Button {
                            selectedPackage = "GOLD 14.99$ 50MB"
                        } label: {
                            Text("GOLD 14.99$ 50MB")
                        }
                        Button {
                            selectedPackage = "PRO 9.99$ 25MB"
                        } label: {
                            Text("PRO 9.99$ 25MB")
                        }
                        Button {
                            selectedPackage = "BASIC 4.99$ 10MB"
                        } label: {
                            Text("BASIC 4.99$ 10MB")
                        }
                    } label: {
                        if let user = authVM.currentUser {
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
                }
                Divider()
                HStack {
                    Spacer()
                    Button {
                        print("Updated ")
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
}

struct ProfileEditView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileEditView(editType: ProfileEdit.packageType)
            .environmentObject(AuthViewModel())
    }
}

