import Foundation
import Combine
import RealmSwift
import Realm

class HistoryDetailViewModel : ObservableObject {
    
    @Published var image: UIImage? = nil
    
    init(imageUrl: String) {
        self.loadImage(imageUrl:imageUrl)
    }
    
    func loadImage(imageUrl: String) {
        guard let url = URL(string: imageUrl) else {
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
