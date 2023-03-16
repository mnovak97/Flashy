//
//  SearchViewModel.swift
//  Flashy
//
//  Created by Martin Novak on 16.03.2023..
//

import Foundation
class SearchViewModel : ObservableObject {
    @Published var pictures =  [Picture]()
    @Published var searchText = ""
    let service = ImageService()
    
    var searchablePictures : [Picture] {
        if searchText.isEmpty {
            return [Picture]()
        } else {
            let lowercasedQuery = searchText.lowercased()
            return pictures.filter {
                $0.author.contains(lowercasedQuery)
            }
        }
    }
    
    init() {
        fetchPictures()
    }
    
    func fetchPictures() {
        service.fetchPictures { pictures in
            self.pictures = pictures
        }
    }
}
