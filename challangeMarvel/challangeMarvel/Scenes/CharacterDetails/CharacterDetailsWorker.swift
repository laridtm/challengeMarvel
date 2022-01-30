import Foundation
import UIKit

protocol CharacterDetailsWorkerProtocol {
    func getComics(url: String, completion: @escaping (Result<Data, Error>) -> Void)
}

final class CharacterDetailsWorker: CharacterDetailsWorkerProtocol {
    private let httpClient = HTTPClient()
    
    func getComics(url: String, completion: @escaping (Result<Data, Error>) -> Void) {
        let urlCredentials = Authentication.formatUrlWithCredentials(url: url)
                
        if let apiUrl = URL(string: urlCredentials) {
            httpClient.get(url: apiUrl) { result -> Void in
                completion(result)
            }
        }
    }
}
