import SwiftUI
import PhotosUI
import CoreML
import UIKit
import Vision

struct PhotoView: View {
    
    @State var selectedItems: [PhotosPickerItem] = []
    @State var data: Data?
    @State var isShown = false
    @State var sourceType: UIImagePickerController.SourceType = .camera
    @State var selectedImage: UIImage?
    
    @StateObject var photoViewModel = PhotoViewModel()
    
    var body: some View {
        VStack {
            if let data = data, let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 300)

                    List {
                        Section("Machine identifies this object as:") {
                            ForEach(photoViewModel.detectedObjects ?? [], id: \.self) { item in
                                NavigationLink(destination: CategoryDetailView(category: photoViewModel.identifyCategory(obj: item.identifier))) {
                                    Text(item.identifier.capitalized)
                                }
                            }
                        }
                    }
                    .listStyle(.inset)
                    .frame(height: 200)
            } else {
                Image("Placeholder")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 300)
            }
            
            Picker
        }
        .sheet(isPresented: self.$isShown) {
            ImagePickerView(selectedImage: self.$selectedImage, sourceType: self.sourceType)
        }
        
        Spacer()
    }
}

extension PhotoView {
    
    var Picker : some View {
        PhotosPicker(
            selection: $selectedItems,
            maxSelectionCount: 1,
            matching: .images
        ) {
            Text("Pick Photo")
                .font(.system(size: 20, weight: Font.Weight.bold))
                .foregroundColor(Color.white)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(RoundedRectangle(cornerRadius: 15).fill(Color.green))
                .frame(width: 300, height: 50)
        }.onChange(of:  selectedItems) { newValue in
            guard let item = selectedItems.first else {
                return
            }
            
            item.loadTransferable(type: Data.self) { result in
                switch result {
                case .success(let data):
                    if let data = data {
                        self.data = data
                        photoViewModel.pictureIdentifyML(image: UIImage(data: data)!)
                    } else {
                        print("Data is nil")
                    }
                case .failure(let failure):
                    fatalError("\(failure)")
                }
            }
        }
    }
}

struct PhotoView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoView()
    }
}
