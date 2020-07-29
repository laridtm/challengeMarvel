//
//  CharacterDetailsWorker.swift
//  challangeMarvel
//
//  Created by Larissa Diniz on 29/07/20.
//  Copyright © 2020 Larissa Diniz. All rights reserved.
//

import Foundation
import UIKit

protocol CharacterDetailsWorkerProtocol: class {
    func getCharacterImage(url: String, completion: @escaping ((UIImage?) -> Void))
    func getComics(url: String, completion: @escaping (([Comic]) -> Void))
    func decode(data: Data) -> [Comic]?
}

class CharacterDetailsWorker: CharacterDetailsWorkerProtocol {
    
    let httpClient = HTTPClient()
    let authentication = Authentication()
    
    func getCharacterImage(url: String, completion: @escaping ((UIImage?) -> Void)) {
        if let apiUrl = URL(string: url) {
            httpClient.get(url: apiUrl) { result -> Void in
                switch result {
                case .failure:
                    break
                case .success(let data):
                    let loadedImage = UIImage(data: data)
                    completion(loadedImage)
                    break
                }
            }
        }
    }
    
    func getComics(url: String, completion: @escaping (([Comic]) -> Void)) {
        let urlCredentials = authentication.addCredentials(url: url)
        
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
