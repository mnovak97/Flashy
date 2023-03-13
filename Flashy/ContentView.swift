//
//  ContentView.swift
//  Flashy
//
//  Created by Martin Novak on 21.12.2022..
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        Group {
            if viewModel.userSession == nil {
                LoginScreenView()
            } else {
                BottomNavigationView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(AuthViewModel())
    }
}
