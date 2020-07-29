//
//  CharactersListWorker.swift
//  challangeMarvel
//
//  Created by Larissa Diniz on 28/07/20.
//  Copyright © 2020 Larissa Diniz. All rights reserved.
//

import Foundation
import CryptoKit

protocol CharactersListWorkerProtocol: class {
    func get(url: String, publicKey: String, privateKey: String, completion: @escaping (([Character]) -> Void))
    func decode(data: Data) -> [Character]?
}

class CharactersListWorker: CharactersListWorkerProtocol {
    
    let httpClient = HTTPClient()
    
    func get(url: String, publicKey: String, privateKey: String, completion: @escaping (([Character]) -> Void)) {
        let urlCredentials = addCredentials(url: url, publicKey: publicKey, privateKey: privateKey)
        
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
    
    func addCredentials(url: String, publicKey: String, privateKey: String) -> String {
        let ts = Date().timeIntervalSince1970
        let hashData = "\(ts)\(privateKey)\(publicKey)"
        let hash = MD5(string: hashData)
        
        return "\(url)?ts=\(ts)&apikey=\(publicKey)&hash=\(hash)"
    }
    
    func MD5(string: String) -> String {
        let digest = Insecure.MD5.hash(data: string.data(using: .utf8) ?? Data())
        
        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
    
    func decode(data: Data) -> [Character]? {
        let result = try? JSONDecoder().decode(CharacterDataWrapper.self, from: data)
        return result?.data?.results
    }
}
