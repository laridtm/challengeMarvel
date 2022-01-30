import Foundation

protocol CharactersListWorkerProtocol {
    func getCharacters(url: String, paginationParameters: MarvelAPIPaginationParameters, completion: @escaping(Result<Data, Error>) -> Void)
}

final class CharactersListWorker: CharactersListWorkerProtocol {
    private let httpClient = HTTPClient()
    
    func getCharacters(url: String,
                       paginationParameters: MarvelAPIPaginationParameters,
                       completion: @escaping (Result<Data, Error>) -> Void) {
        var urlCredentials = Authentication.formatUrlWithCredentials(url: url)
        urlCredentials = addAPIParameters(url: urlCredentials,
                                          limit: paginationParameters.limit,
                                          offset: paginationParameters.offset)
                
        if let apiUrl = URL(string: urlCredentials) {
            httpClient.get(url: apiUrl) { result -> Void in
                completion(result)
            }
        }
    }
    
    func addAPIParameters(url: String, limit: Int?, offset: Int?) -> String {
        guard let limit = limit else { return url }
        guard let offset = offset else { return url }
        
        return "\(url)&limit=\(limit)&offset=\(offset)"
    }
}
