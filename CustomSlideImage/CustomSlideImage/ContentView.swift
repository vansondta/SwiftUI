//
//  ContentView.swift
//  CustomSlideImage
//
//  Created by SonNV3 on 30/08/2023.
//

import SwiftUI
import Photos

struct ContentView: View {
    // MARK: picker properties
    @State var showPicker: Bool = false
    @State var pickerImages: [UIImage] = []
    var body: some View {
        NavigationView {
            TabView {
                ForEach(pickerImages, id: \.self) { image in
                    GeometryReader { proxy in
                        let size = proxy.size
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: size.width, height: size.height)
                            .cornerRadius(15)
                    }
                    .padding()
                }
            }
            .frame(height: 450)
            // MARK: SwiftUI bug
            // if you dont have any views inslide tabview
            // It's crash, but not in never
            .tabViewStyle(.page(indexDisplayMode: pickerImages.isEmpty ? .never : .always))
            .navigationTitle("Popup image Picker")
            .toolbar {
                Button {
                    showPicker.toggle()
                } label: {
                    Image(systemName: "plus")
                }

            }
        }
        .popupImagePicker(show: $showPicker) { assets in
            // MARK: Do your operation with PHAsset
            // I'm Simply Extracting Image
            // .init() Means Extrac size of in the image
            let manager = PHCachingImageManager.default()
            let options = PHImageRequestOptions()
            options.isSynchronous = true
            DispatchQueue.global(qos: .userInteractive).async {
                assets.forEach { asset in
                    manager.requestImage(for: asset, targetSize: .init(), contentMode: .default, options: options) { image, _ in
                        guard let image = image else { return }
                        DispatchQueue.main.async {
                            self.pickerImages.append(image)
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
