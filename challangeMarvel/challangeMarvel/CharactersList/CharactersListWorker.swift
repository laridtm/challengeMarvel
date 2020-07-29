//
//  CharactersListWorker.swift
//  challangeMarvel
//
//  Created by Larissa Diniz on 28/07/20.
//  Copyright © 2020 Larissa Diniz. All rights reserved.
//

import Foundation

protocol CharactersListWorkerProtocol: class {
    func get(url: String, completion: @escaping (([Character]) -> Void))
    func decode(data: Data) -> [Character]?
}

class CharactersListWorker: CharactersListWorkerProtocol {
    
    let httpClient = HTTPClient()
    let authentication = Authentication()
    
    func get(url: String, completion: @escaping (([Character]) -> Void)) {
        let urlCredentials = authentication.addCredentials(url: url)
        
        if let apiUrl = URL(string: urlCredentials) {
            httpClient.get(url: apiUrl) { result -> Void in
                switch result {
                case .failure:
                    break
                case .success(let data):
                    if let characters = self.decode(data: data){
                        completion(characters)
                    }
                    break
                }
            }
        }
    }
    
    func decode(data: Data) -> [Character]? {
        let result = try? JSONDecoder().decode(CharacterDataWrapper.self, from: data)
        return result?.data?.results
    }
}
