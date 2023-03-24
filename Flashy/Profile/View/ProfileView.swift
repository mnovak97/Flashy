//
//  ProfileView.swift
//  Flashy
//
//  Created by Martin Novak on 22.12.2022..
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel = ProfileViewModel()
    @EnvironmentObject var authVM : AuthViewModel
    var body: some View {
        VStack {
            VStack {
                if viewModel.user != nil {
                    Text(viewModel.user!.username)
                        .fontWeight(.bold)
                        .font(.custom("Futura-MediumItalic", fixedSize: 25))
                }
            }
            .frame(
                  minWidth: 0,
                  maxWidth: .infinity,
                  minHeight: 0,
                  maxHeight: 150
                )
            
            VStack {
                HStack {
                    Text("Package type:")
                        .fontWeight(.bold)
                        .font(.custom("Futura-MediumItalic", fixedSize: 18))
                    if viewModel.user != nil {
                        Text(viewModel.user!.packageType)
                    }
                }
                
                HStack{
                    Text("Usage")
                        .fontWeight(.bold)
                        .font(.custom("Futura-MediumItalic", fixedSize: 18))
                    if viewModel.user != nil {
                        ProgressBarView(width: 150,height: 20,percent: CGFloat(viewModel.totalUsage),packageSpace: CGFloat(viewModel.user!.packageMaxConsumption),color1: Color(.systemBlue),color2: Color(.blue))
                            .animation(.spring())
                        Text("\(viewModel.totalUsage)/\(viewModel.user!.packageMaxConsumption)")
                    }
                }
                
                .padding(.top,20)
                .padding(.bottom,20)
                if let user = authVM.userSession {
                    if let provider = user.providerData.first {
                        if provider.providerID != "google.com" {
                            Divider()
                            NavigationLink {
                                ProfileEditView(editType: ProfileEdit.password)
                            } label: {
                                CustomListItem(imageName: "lock", text: "Change password")
                            }
                            .foregroundColor(.black)
                            Divider()
                            NavigationLink {
                                ProfileEditView(editType: ProfileEdit.email)
                            } label: {
                                CustomListItem(imageName: "envelope", text: "Change e-mail")
                            }
                            .foregroundColor(.black)
                        }
                    }
                }
                Divider()
                NavigationLink {
                    ProfileEditView(editType: ProfileEdit.packageType)
                } label: {
                    CustomListItem(imageName: "externaldrive.badge.person.crop", text: "Change package plan")
                }
                .foregroundColor(.black)
                .padding(.bottom,20)
                    
            }
            .frame(
                  minWidth: 0,
                  maxWidth: .infinity,
                  minHeight: 0,
                  maxHeight: .infinity
                )
            .background(Color(.systemGray5))
            .clipShape(CustomShape(corners: [.topLeft,.topRight,.bottomLeft,.bottomRight]))
            .padding()
        }
        .onAppear{
            self.viewModel.fetchTotalUsage()
            if authVM.userUpdated {
                self.viewModel.getUser()
                self.authVM.userUpdated = false
                self.viewModel.fetchTotalUsage()
            }
        }
    }
}

