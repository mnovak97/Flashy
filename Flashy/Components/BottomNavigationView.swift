//
//  MainView.swift
//  Flashy
//
//  Created by Martin Novak on 22.12.2022..
//

import SwiftUI

struct BottomNavigationView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button {
                        authViewModel.signOut()
                    } label: {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                            .font(.title)
                    }
                    .padding(.leading)

                    Spacer()
                    Text("Flashy")
                        .fontWeight(.bold)
                        .font(.custom("Futura-MediumItalic", fixedSize: 25))
                    Spacer()
                    if authViewModel.currentUser != nil {
                        NavigationLink {
                            ImageUploadView()
                        } label: {
                            Image(systemName: "plus")
                                .font(.title)
                        }
                        .padding(.trailing)
                    } else {
                        NavigationLink {
                            ImageUploadView()
                        } label: {
                            Image(systemName: "plus")
                                .font(.title)
                                .opacity(0)
                        }
                        .disabled(true)
                        .padding(.trailing)
                    }
                }
                Divider()
                    .background(Color.black)
                    .padding(.leading)
                    .padding(.trailing)
                TabView {
                    MainView()
                        .tabItem {
                            Image(systemName: "house.fill")
                        }
                    SearchView()
                        .tabItem {
                            Image(systemName: "magnifyingglass")
                        }
                    if let user = authViewModel.currentUser {
                        ProfileView(user: user)
                            .tabItem {
                                Image(systemName: "person.crop.circle")
                            }
                    }
                }
            }
        }
        
    }
}

struct BottomNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        BottomNavigationView().environmentObject(AuthViewModel())
    }
}
