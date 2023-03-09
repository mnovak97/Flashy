//
//  ImageSaver.swift
//  Flashy
//
//  Created by Martin Novak on 08.03.2023..
//

import UIKit

class ImageSave: NSObject {
    var successHandler: (() -> Void)?
    var errorHandler: ((Error) -> Void)?
    
    func writePhotoToAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }
    
    @objc func saveCompleted(_ image:UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
                   errorHandler?(error)
               } else {
                   successHandler?()
               }
    }
}
