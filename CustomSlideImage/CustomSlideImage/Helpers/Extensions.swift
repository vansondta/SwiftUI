//
//  Extensions.swift
//  CustomSlideImage
//
//  Created by SonNV3 on 30/08/2023.
//

import SwiftUI
import Photos

// MARK: Custom Modifier

extension View {
    @ViewBuilder
    func popupImagePicker(show: Binding<Bool>, transition: AnyTransition = .move(edge: .bottom), onselect: @escaping([PHAsset]) -> ()) -> some View {
        self.overlay {
            ZStack {
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .ignoresSafeArea()
                    .opacity(show.wrappedValue ? 1 : 0)
                    .onTapGesture {
                        show.wrappedValue = false
                    }
                
                if show.wrappedValue {
                    PopupImagePickerView {
                        show.wrappedValue = false
                    } onSelect: { asset in
                        onselect(asset)
                        show.wrappedValue = false
                    }
                    .transition(transition)
                }
            }
        }
        .animation(.easeInOut, value: show.wrappedValue)
    }
}
