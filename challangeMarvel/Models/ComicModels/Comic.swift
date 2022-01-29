import Foundation

struct ComicDataContainer: Codable {
    let offset: Int?
    let limit: Int?
    let total: Int?
    let count: Int?
    let results: [Comic]?
}

struct ComicDataWrapper: Codable {
    let code: Int?
    let status: String?
    let copyright: String?
    let attributionText: String?
    let attributionHTML: String?
    let data: ComicDataContainer?
    let etag: String?
}

struct Comic: Codable {
    let id: Int?
    let title: String?
    let thumbnail: Image?
    
    func getComicImage() -> String {
        guard let urlPath = thumbnail?.path else { return "" }
        guard let urlExt = thumbnail?.ext else { return "" }
        
        return "\(urlPath)/portrait_xlarge.\(urlExt)"
    }
}
