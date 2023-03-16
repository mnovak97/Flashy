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
                Spacer()
                Button {
                    searchVM.usernameSelected.toggle()
                    searchVM.hashtagSelected.toggle()
                } label: {
                    Text("username")
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                        .frame(width:150,height: 40)
                        .background(searchVM.usernameSelected ? Color(.systemBlue) : Color(.white))
                        .cornerRadius(5)
                        .shadow(color: Color.black.opacity(0.4), radius: 10, x:0.0, y:2)
                }
                Button {
                    searchVM.usernameSelected.toggle()
                    searchVM.hashtagSelected.toggle()
                } label: {
                    Text("hashtag")
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                        .frame(width:150,height: 40)
                        .background(searchVM.hashtagSelected ? Color(.systemBlue) : Color(.white))
                        .cornerRadius(5)
                        .shadow(color: Color.black.opacity(0.4), radius: 10, x:0.0, y:2)
                    
                }
                Spacer()
            }
            ScrollView {
                LazyVStack {
                    ForEach(searchVM.searchablePictures) { picture in
                        NavigationLink {
                            ImageDetailsView(picture: picture)
                        } label: {
                            SearchThumbnailView(picture: picture)
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
