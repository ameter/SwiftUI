//
//  ImagePicker.swift
//  Instafilter
//
//  This is a version of ImagePicker that takes a closure instead of an image to allow custom actions to be taken when it's set.
//
//  Created by Chris on 4/28/20.
//  Copyright © 2020 CodePika. All rights reserved.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    var onSelect: ((UIImage) -> Void)
        
    init(onSelect: @escaping (UIImage) -> Void) {
        self.onSelect = onSelect
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
    }
    
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.onSelect(uiImage)
            }
        }
    }
}