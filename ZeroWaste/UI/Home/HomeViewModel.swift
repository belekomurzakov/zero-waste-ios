import Foundation
import Combine
import RealmSwift

class HomeViewModel : ObservableObject {
    
    let dateFormatter = DateFormatter()
    
    
    init() {        
        dateFormatter.setLocalizedDateFormatFromTemplate("dd-MM-yyyy HH:mm")
    }
}
