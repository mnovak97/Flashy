//
//  ProfileView.swift
//  Flashy
//
//  Created by Martin Novak on 22.12.2022..
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel: ProfileViewModel
    
    init(user: User) {
        self.viewModel = ProfileViewModel(user: user)
    }
    var body: some View {
        VStack {
            VStack {
                Text(viewModel.user.username)
                    .fontWeight(.bold)
                    .font(.custom("Futura-MediumItalic", fixedSize: 25))
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
                    Text(viewModel.user.packageType)
                    
                }
                
                HStack{
                    Text("Usage")
                        .fontWeight(.bold)
                        .font(.custom("Futura-MediumItalic", fixedSize: 18))
                    
                    ProgressBarView(width: 150,height: 20,percent: CGFloat(viewModel.totalUsage),packageSpace: CGFloat(viewModel.packageMaxConsumption),color1: Color(.systemBlue),color2: Color(.blue))
                        .animation(.spring())
                    Text("\(viewModel.totalUsage / 1000)/\(viewModel.packageMaxConsumption / 1000) MB")
                }
                
                .padding(.top,20)
                .padding(.bottom,20)
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
    }
}

