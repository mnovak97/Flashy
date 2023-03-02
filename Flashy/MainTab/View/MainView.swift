//
//  MainView.swift
//  Flashy
//
//  Created by Martin Novak on 22.12.2022..
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel = MainTabViewModel()
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(viewModel.pictures) { picture in
                        NavigationLink {
                            ImageDetailsView(picture: picture)
                        } label: {
                            ThumbnailView(picture: picture)
                                .foregroundColor(.black)
                        }
                    }
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
