//
//  SearchView.swift
//  Flashy
//
//  Created by Martin Novak on 22.12.2022..
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    var body: some View {
        VStack {
            SearchBar(text: $searchText)
                .padding()
            ScrollView {
                LazyVStack {
                    
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
