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
    func getMore(url: String, completion: @escaping (([Character]) -> Void))
    func decode(data: Data) -> [Character]?
}

class CharactersListWorker: CharactersListWorkerProtocol {
    
    var offset: Int?
    var limit: Int?
    var total: Int?
    var count = 0
    
    let httpClient = HTTPClient()
    let authentication = Authentication()
    
    func get(url: String, completion: @escaping (([Character]) -> Void)) {
        var urlCredentials = authentication.addCredentials(url: url)
        urlCredentials = addAPIParameters(url: urlCredentials, limit: 100, offset: 0)
        
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
    
    func getMore(url: String, completion: @escaping (([Character]) -> Void)) {
        var urlCredentials = authentication.addCredentials(url: url)
        urlCredentials = addAPIParameters(url: urlCredentials, limit: limit, offset: offset)
        
        if count == total {
            completion([Character]())
        }
        
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
    
    func addAPIParameters(url: String, limit: Int?, offset: Int?) -> String {
        guard let limit = limit else { return url }
        guard let offset = offset else { return url }
        
        return "\(url)&limit=\(limit)&offset=\(offset)"
    }
    
    func decode(data: Data) -> [Character]? {
        let result = try? JSONDecoder().decode(CharacterDataWrapper.self, from: data)
        
        limit = result?.data?.limit
        total = result?.data?.total
        
        if let countResult = result?.data?.count {
            count = countResult + count
        }
        
        offset = count
        return result?.data?.results
    }
}
