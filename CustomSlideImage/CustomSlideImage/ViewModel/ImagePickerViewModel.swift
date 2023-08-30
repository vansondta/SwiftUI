//
//  ImagePickerViewModel.swift
//  CustomSlideImage
//
//  Created by SonNV3 on 30/08/2023.
//

import SwiftUI
import PhotosUI

class ImagePickerViewModel: ObservableObject {
    // MARK: Properties
    @Published var fetchedImages: [ImageAsset] = []
    @Published var selectedImages: [ImageAsset] = []
    
    init() {
        fetchImages()
    }
    
    // MARK: fetching images
    func fetchImages() {
        let options = PHFetchOptions()
        // MARK: modify as per your wish
        options.includeHiddenAssets = false
        options.includeAssetSourceTypes = [.typeUserLibrary]
        options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        PHAsset.fetchAssets(with: .image, options: options).enumerateObjects { asset, _, _ in
            let imageAsset: ImageAsset = .init(asset: asset)
            self.fetchedImages.append(imageAsset)
        }
    }
}
