import Foundation
import SwiftUI
import Combine

class CategoryDetailViewModel : ObservableObject {
    
    @Published var wasteType: WasteType = Constant.wasteType
    @Published var image: UIImage? = nil
    
    @State var isLoading = true
    @State private var cancellable: AnyCancellable?
    
    var remoteRepositoryImpl = RemoteRepository()
    
    init(category: String) {
        fetchWasteTypeInfo(category: category)
    }
    
    func fetchWasteTypeInfo(category: String) {
        Task {
            let result = await remoteRepositoryImpl.fetchWasteTypeInfo(category:  category)
            
            switch (result) {
            case let .success(data):
                DispatchQueue.main.async {
                    self.wasteType = data
                    self.loadImage()
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func loadImage() {
        guard let url = URL(string: wasteType.imageUrl) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = image
                }
            } else {
            }
        }
        
        task.resume()
    }
}
