
import SwiftUI
import UIKit

enum PhotoSheetType: Identifiable {
    var id: UUID {
        UUID()
    }
    case gallery
    case picture
}


struct ContentView: View {
 
    @State private var showingActionSheet = false
    @State private var showingType: PhotoSheetType?
    @State var imageTemp : Data = (UIImage(systemName: "photo.on.rectangle.angled")?.jpegData(compressionQuality: 1))!
        
    
    var body: some View {
            NavigationView {
                Image(uiImage: UIImage(data: imageTemp)!)
                    .resizable()
                    .scaledToFit()
                    
                    .onTapGesture {
                        self.showingActionSheet = true
                    }
                    .actionSheet(isPresented: $showingActionSheet) {
                        ActionSheet(
                            title: Text("Image selector"),
                            message: Text("Select an image"),
                            buttons: [
                                .default(Text("Select from Gallery")) {
                                    showingType = .gallery
                                },
                                .default(Text("Take new picture")) {
                                    showingType = .picture
                                },
                                .cancel()
                            ]
                        )
                    }
                    .sheet(item: $showingType) { type in
                        if type == .gallery {
                            ImagePicker(sourceType: .photoLibrary, showingType: $showingType, image: self.$imageTemp)
                        } else {
                            ImagePicker(sourceType: .camera, showingType: $showingType, image: self.$imageTemp)
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
