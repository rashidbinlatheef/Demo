import Foundation
import UIKit

final class ThingModel: Codable {
    let name: String
    var image: String?
    var type: String?
    let uuid: String
    var like: Bool?

    enum CodingKeys: String, CodingKey {
        case name, like, image, type, uuid
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        type = try? values.decode(String.self, forKey: .type)
        uuid = try values.decode(String.self, forKey: .uuid)
        let imageUrlString = try? values.decode([String].self, forKey: .image)
        image = imageUrlString?.first
    }
}
























