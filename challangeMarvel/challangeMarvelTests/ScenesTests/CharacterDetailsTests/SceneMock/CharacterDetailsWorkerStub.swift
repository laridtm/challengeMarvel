import Foundation

final class CharacterDetailsWorkerStub: CharacterDetailsWorkerProtocol {
    var result: Result<Data, Error>?
    
    func getComics(url: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let result = result else {
           return
       }
       completion(result.map { $0 })
    }
}
