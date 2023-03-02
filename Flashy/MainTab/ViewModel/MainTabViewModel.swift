//
//  MainTabViewModel.swift
//  Flashy
//
//  Created by Martin Novak on 13.02.2023..
//

import Foundation

class MainTabViewModel: ObservableObject {
    @Published var pictures = [Picture]()
    let userService = UserService()
    let imageService = ImageService()
    
    init() {
        fetchPictures()
    }
    
    func fetchPictures() {
        imageService.fetchPictures { pictures in
            self.pictures = pictures
        }
    }
    
}
