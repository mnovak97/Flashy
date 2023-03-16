//
//  ImageDetailViewModel.swift
//  Flashy
//
//  Created by Martin Novak on 09.03.2023..
//

import Foundation
import SwiftUI

class ImageDetailViewModel : ObservableObject {
    @Published var image: Image?
    var loadedImage: UIImage?
    var selectedFilterName: String?
    var filteredCgImage: CGImage?
    let imageService = ImageService()
    let filters = [
            "CISepiaTone",
            "CIPhotoEffectFade",
            "CIPhotoEffectInstant",
            "CIPhotoEffectMono",
            "CIPhotoEffectNoir",
            "CIPhotoEffectProcess",
            "CIPhotoEffectTonal",
            "CIPhotoEffectTransfer"
        ]
    
    func loadImage(from url: String) {
        guard let imageURL = URL(string: url) else { return }
        
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try Data(contentsOf: imageURL)
                guard let loadedImage = UIImage(data: data) else { return }
                self.loadedImage = loadedImage
                self.applySelectedFilter()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func update(pictureURL:String,description:String,hashtags:String) {
        self.imageService.updatePicture(pictureUrl: pictureURL, description: description, hashtags: hashtags)
    }
    
    func applySelectedFilter() {
        guard let loadedImage = self.loadedImage else { return }
        
        // Apply the selected filter to the loaded image
        if let selectedFilterName = self.selectedFilterName {
            if let selectedFilter = CIFilter(name: selectedFilterName) {
                let ciImage = CIImage(image: loadedImage)
                selectedFilter.setValue(ciImage, forKey: kCIInputImageKey)
                guard let outputCIImage = selectedFilter.outputImage else { return }
                let context = CIContext()
                guard let outputCGImage = context.createCGImage(outputCIImage, from: outputCIImage.extent) else { return }
                self.filteredCgImage = outputCGImage
                let image = UIImage(cgImage: outputCGImage)
                if image.imageOrientation == UIImage.Orientation.up {
                    let filteredImage = Image(uiImage: image)
                    DispatchQueue.main.async {
                        self.image = filteredImage
                    }
                } else {
                    let fixedCGImage = outputCGImage.copy()!
                    let fixedImage = UIImage(cgImage: fixedCGImage, scale: image.scale, orientation: .down)
                    let filteredImage = Image(uiImage: fixedImage)
                    DispatchQueue.main.async {
                        self.image = filteredImage
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.image = Image(uiImage: loadedImage)
                }
            }
        } else {
            DispatchQueue.main.async {
                self.image = Image(uiImage: loadedImage)
            }
        }
    }
    
    func saveToPhotoAlbum() {
        if let cgImage = filteredCgImage {
            let uiImage = UIImage(cgImage: cgImage)
            UIImageWriteToSavedPhotosAlbum(uiImage, nil, nil, nil)
        }
    }
}

