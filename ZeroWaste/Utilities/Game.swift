import Foundation

enum Level : String {
    case Explorer = "Explorer"
    case Scout = "Scout"
    case Expeditioner = "Expeditioner"
    case Ranger = "Ranger"
    case Champion = "Champion"
    
    func image() -> String {
        switch self {
        case .Explorer:
            return  "Elephant"
        case .Scout:
            return  "Panda"
        case .Expeditioner:
            return  "Chicken"
        case .Ranger:
            return  "Horse"
        case .Champion:
            return "Tiger"
        }
     }
}

@MainActor class Game: ObservableObject {
        
    func getLevel(point: Int) -> Level {
        switch point {
        case 0..<10 : return Level.Explorer
        case 10..<20 : return Level.Scout
        case 20..<30 : return Level.Expeditioner
        case 30..<40 : return Level.Ranger
        default: return Level.Champion
        }
    }
}
