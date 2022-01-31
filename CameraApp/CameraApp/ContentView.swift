
import SwiftUI
import UIKit

enum PhotoSheetType: Identifiable { /// 1.
    var id: UUID {
        UUID()
    }
    case gallery
    case picture
}


struct ContentView: View {
 
    @State private var isShowPhotoLibrary = false
    @State private var image = UIImage()
 
    @State private var showingType: PhotoSheetType?
    @State var imageTemp : Data = (UIImage(systemName: "photo.on.rectangle.angled")?.jpegData(compressionQuality: 1))!
        
    
    var body: some View {
        HStack {
 
            Image(uiImage: self.image)
                .resizable()
                .scaledToFill()
                .frame(minWidth: 0, maxWidth: .infinity)
                .edgesIgnoringSafeArea(.all)
 
            Button(action: {
                self.isShowPhotoLibrary = true
            }) {
                HStack {
                    Image(systemName: "photo")
                        .font(.system(size: 20))
 
                    Text("Photo library")
                        .font(.headline)
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(20)
                .padding(.horizontal)
            }
        }
        .sheet(isPresented: $isShowPhotoLibrary) {
            ImagePicker(selectedImage: self.$image, sourceType: .photoLibrary)
        }
        
        VStack {
 
            Button(action: {
                self.isShowPhotoLibrary = false
                showingType = .picture
            }) {
                HStack {
                    Image(systemName: "photo")
                        .font(.system(size: 20))
                        
                    Text("Take Picture")
                        .font(.headline)
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(20)
                .padding(.horizontal)
            }
        }
    }
}

func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
 
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
