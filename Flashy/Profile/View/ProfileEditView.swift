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
    @StateObject private var viewModel = ProfileEditViewModel()
    @EnvironmentObject var authVM : AuthViewModel
    var body: some View {
        switch editType {
        case .password:
            VStack (alignment:.leading) {
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
                        if let userID = authVM.userSession?.uid {
                            viewModel.updatePassword(uid: userID, newPassword: text)
                        }
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
                        if let userID = authVM.userSession?.uid {
                            viewModel.updateEmail(uid: userID, newEmail: text)
                        }
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
                        if let userID = authVM.userSession?.uid {
                            viewModel.updatePackagePlan(uid: userID, packagePlan: selectedPackage, consumption: getMaxConsumption())
                            authVM.userUpdated = true
                        }
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
    func getMaxConsumption() -> Int {
        var consumption = 0
            if let package = selectedPackage.components(separatedBy: " ").first {
                if package == "GOLD" {
                    consumption = 50
                } else if package == "PRO" {
                    consumption = 25
                } else if package == "BASIC" {
                    consumption = 10
                }
            }
        return consumption
    }
}

struct ProfileEditView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileEditView(editType: ProfileEdit.password)
            .environmentObject(AuthViewModel())
    }
}

