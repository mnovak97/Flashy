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
                    Spacer()
                    
                    Text("Flashy")
                        .fontWeight(.bold)
                        .font(.custom("Futura-MediumItalic", fixedSize: 25))
                        .padding(.leading, 50)
                    Spacer()
                    
                    NavigationLink {
                        ImageUploadView()
                    } label: {
                        Image(systemName: "plus")
                            .font(.title)
                    }
                    .padding(.trailing)
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
        BottomNavigationView()
    }
}
