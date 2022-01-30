import Foundation

struct CharacterComicSummary: Codable {
    let resourceURI: String?
    let name: String?
}

struct CharacterComicList: Codable {
    let available: Int?
    let returned: Int?
    let collectionURI: String?
    let items: [CharacterComicSummary]?
    
    init(available: Int?, returned: Int?, collectionURI: String?, items: [CharacterComicSummary]?) {
        self.available = available
        self.returned = returned
        self.collectionURI = collectionURI
        self.items = items
    }
}
