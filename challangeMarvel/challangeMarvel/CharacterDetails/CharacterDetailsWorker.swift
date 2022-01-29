import Foundation
import UIKit

protocol CharacterDetailsWorkerProtocol {
    func getComics(url: String, completion: @escaping (([Comic]) -> Void))
    func decode(data: Data) -> [Comic]?
}

final class CharacterDetailsWorker: CharacterDetailsWorkerProtocol {
    private let httpClient = HTTPClient()
    
    func getComics(url: String, completion: @escaping (([Comic]) -> Void)) {
        let urlCredentials = Authentication.formatUrlWithCredentials(url: url)
        
        if let apiUrl = URL(string: urlCredentials) {
            httpClient.get(url: apiUrl) { result -> Void in
                switch result {
                case .failure:
                    break
                case .success(let data):
                    if let comics = self.decode(data: data){
                        completion(comics)
                    }
                    break
                }
            }
        }
    }
    
    func decode(data: Data) -> [Comic]? {
        let result = try? JSONDecoder().decode(ComicDataWrapper.self, from: data)
        return result?.data?.results
    }
}
