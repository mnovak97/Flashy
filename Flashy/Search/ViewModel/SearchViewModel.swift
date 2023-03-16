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
    @Published var usernameSelected = true
    @Published var hashtagSelected = false
    let service = ImageService()
    
    var searchablePictures : [Picture] {
        if searchText.isEmpty {
            return [Picture]()
        } else {
            let lowercasedQuery = searchText.lowercased()
            return filter(query: lowercasedQuery)
        }
    }
    
    func filter(query:String) -> [Picture] {
        if usernameSelected {
            return pictures.filter { $0.author.contains(query)}
        } else {
            return pictures.filter { $0.hashtags.contains(query)}
        }
    }
    
    func filterHashtags(query:String) -> [Picture] {
        return pictures.filter { $0.hashtags.contains(query)}
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
