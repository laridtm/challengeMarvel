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
}

class CharactersListWorker: CharactersListWorkerProtocol {

    var httpClient = HTTPClient()
    
    func get(url: String, completion: @escaping (([Character]) -> Void)) {
        if let url = URL(string: url) {
            httpClient.get(url: url) { result -> Void in
                switch result {
                case .failure:
                    break
                case .success(let data):
                    
                    break
                }
            }
        }
    }
}
