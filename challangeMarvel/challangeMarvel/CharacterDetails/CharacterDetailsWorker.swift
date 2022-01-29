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
    func getComics(url: String, completion: @escaping (([Comic]) -> Void))
    func decode(data: Data) -> [Comic]?
}

class CharacterDetailsWorker: CharacterDetailsWorkerProtocol {
    
    let httpClient = HTTPClient()
    
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
