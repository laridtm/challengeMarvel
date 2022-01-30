import Foundation

protocol MarvelAPIParserProtocol {
    var paginationParameters: MarvelAPIPaginationParameters { get }
    func parseToCharacters(data: Data) -> [Character]?
    func parseToComics(data: Data) -> [Comic]?
}

struct MarvelAPIPaginationParameters {
    var offset: Int
    var limit: Int
    var total: Int
    var count: Int
}

final class MarvelAPIParser: MarvelAPIParserProtocol {
    var paginationParameters = MarvelAPIPaginationParameters(offset: 0, limit: 100, total: 0, count: 0)
    
    func parseToCharacters(data: Data) -> [Character]? {
        let result = try? JSONDecoder().decode(CharacterDataWrapper.self, from: data)
        
        if let limit = result?.data?.limit {
            paginationParameters.limit = limit
        }
        if let total = result?.data?.total {
            paginationParameters.total = total
        }
        if let countResult = result?.data?.count {
            paginationParameters.count = countResult + paginationParameters.count
        }
        
        paginationParameters.offset = paginationParameters.count
        
        return result?.data?.results
    }
    
    func parseToComics(data: Data) -> [Comic]? {
        let result = try? JSONDecoder().decode(ComicDataWrapper.self, from: data)
        return result?.data?.results
    }
}
