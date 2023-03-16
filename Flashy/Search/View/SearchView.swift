//
//  SearchView.swift
//  Flashy
//
//  Created by Martin Novak on 22.12.2022..
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var searchVM = SearchViewModel()
    var body: some View {
        VStack {
            SearchBar(text: $searchVM.searchText)
                .padding()
            HStack {
                
            }
            ScrollView {
                LazyVStack {
                    ForEach(searchVM.searchablePictures) { picture in
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

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
