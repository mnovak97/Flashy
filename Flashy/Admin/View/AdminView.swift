//
//  AdminView.swift
//  Flashy
//
//  Created by Martin Novak on 21.03.2023..
//

import SwiftUI

struct AdminView: View {
    @ObservedObject var viewModel = AdminViewModel()
    
    var body: some View {
        VStack {
            SearchBar(text: $viewModel.searchText)
                .padding()
            Spacer()
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.searchableUsers) { user in
                        NavigationLink {
                            UpdatePackageView(user: user)
                        } label: {
                            UsersThumbnail(user: user)
                                .foregroundColor(.black)
                        }
                    }
                }
            }
        }
    }
}

struct AdminView_Previews: PreviewProvider {
    static var previews: some View {
        AdminView()
    }
}
