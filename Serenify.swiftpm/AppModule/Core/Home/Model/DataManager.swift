//
//  File.swift
//  Serenify
//
//  Created by Elyan Gutierrez on 11/19/24.
//

import Foundation
import SwiftUI

@Observable
class DataManager {
    var displayedImage: Image?
    
    func convertUIImageToImage(image: UIImage) {
        let uiImage = image
        
        displayedImage = Image(uiImage: uiImage)
    }
    
    @MainActor func convertImageToData(image: UIImage) -> Data? {
        
        // TODO: Convert to svg instead of jpeg
        
//        let imageData = image.jpegData(compressionQuality: 0.90)
        
        let imageData = image.pngData()
        
        guard let imageData else { return nil }
        print("Converted image to data.")
        return imageData
    }
}
