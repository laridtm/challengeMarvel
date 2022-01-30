import Foundation

struct Image: Codable {
    let path: String?
    let ext: String?
    
    enum CodingKeys: String, CodingKey {
        case path = "path"
        case ext = "extension"
    }
}
