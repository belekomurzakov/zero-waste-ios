import Foundation
import MapKit

struct Can: Decodable, Identifiable {
    let id: String
    let latitude: Double
    let longitude: Double
    let tid: Int
    let typeWasteSeparated: String?
    let commodityWasteSeparated: String
    let owner: String?
    let name: String
    let street: String?
    let cp: Int
    let isPublic: String?
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: latitude,
            longitude: longitude)
    }
    
    init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            id = try container.decode(String.self, forKey: .id)
            latitude = try container.decode(Double.self, forKey: .latitude)
            longitude = try container.decode(Double.self, forKey: .longitude)
            tid = try container.decode(Int.self, forKey: .tid)
            typeWasteSeparated = try container.decodeIfPresent(String.self, forKey: .typeWasteSeparated)
            commodityWasteSeparated = try container.decode(String.self, forKey: .commodityWasteSeparated)
            owner = try container.decodeIfPresent(String.self, forKey: .owner)
            name = try container.decode(String.self, forKey: .name)
            street = try container.decodeIfPresent(String.self, forKey: .street)
            cp = try container.decode(Int.self, forKey: .cp)
            isPublic = try container.decodeIfPresent(String.self, forKey: .isPublic)
        }

    private enum CodingKeys: String, CodingKey {
            case id = "id"
            case latitude = "latitude"
            case longitude = "longitude"
            case tid = "tid"
            case typeWasteSeparated = "type_waste_separated"
            case commodityWasteSeparated = "commodity_waste_separated"
            case owner = "owner"
            case name = "name"
            case street = "street"
            case cp = "cp"
            case isPublic = "isPublic"
        }
}
