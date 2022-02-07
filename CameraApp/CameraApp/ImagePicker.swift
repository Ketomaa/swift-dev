import Foundation
import UIKit
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    @Binding var showingType: PhotoSheetType?
    @Binding var image: Data
    
    func makeCoordinator() -> ImagePicker.Coordinator {
        let imagePicker = UIImagePickerController()
        return ImagePicker.Coordinator(child1: self)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = sourceType
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var child : ImagePicker
        init(child1: ImagePicker) {
            child = child1
        }
        
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            self.child.showingType = nil /// set to nil here
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            let image = info[.originalImage] as! UIImage
            let data = image.jpegData(compressionQuality: 0.45)
            self.child.image = data!
            self.child.showingType = nil /// set to nil here
        }
    }
}
