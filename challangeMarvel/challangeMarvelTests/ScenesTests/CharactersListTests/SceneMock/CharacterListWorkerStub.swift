import Foundation

final class CharacterListWorkerStub: CharactersListWorkerProtocol {
    var result: Result<Data, Error>?
    
    func getCharacters(url: String, paginationParameters: MarvelAPIPaginationParameters, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let result = result else {
            return
        }
        completion(result.map { $0 })
    }
}
