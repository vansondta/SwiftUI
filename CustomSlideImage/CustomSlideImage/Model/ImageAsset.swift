//
//  ImageAsset.swift
//  CustomSlideImage
//
//  Created by SonNV3 on 30/08/2023.
//

import SwiftUI
import PhotosUI

// MARK: Selected Image asset model
struct ImageAsset: Identifiable {
    var id: String = UUID().uuidString
    var asset: PHAsset
    var thumbnail: UIImage?
    // MARK: Selected image index
    var assetIndex: Int = -1
}
