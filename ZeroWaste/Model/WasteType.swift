import Foundation

struct WasteType: Decodable {
    var description: String
    var imageUrl: String
    var decompositionTime: String
    var kills: Int
    var cans: Int
    
    private enum CodingKeys: String, CodingKey {
        case description = "description"
        case imageUrl = "image_url"
        case decompositionTime = "decomposition_time"
        case kills = "kills"
        case cans = "cans"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        description = try container.decode(String.self, forKey: .description)
        imageUrl = try container.decode(String.self, forKey: .imageUrl)
        decompositionTime = try container.decode(String.self, forKey: .decompositionTime)
        kills = try container.decode(Int.self, forKey: .kills)
        cans = try container.decode(Int.self, forKey: .cans)
    }
}
