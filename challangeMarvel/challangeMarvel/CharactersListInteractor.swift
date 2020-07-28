//
//  CharactersListInteractor.swift
//  challangeMarvel
//
//  Created by Larissa Diniz on 28/07/20.
//  Copyright © 2020 Larissa Diniz. All rights reserved.
//

import Foundation

protocol CharactersListInteractorProtocol {
    func onViewLoad()
}

class CharactersListInteractor: CharactersListInteractorProtocol {
    private let presenter: CharactersListPresentable
    private let worker: CharactersListWorkerProtocol
    var url: String = "http://gateway.marvel.com/v1/public/characters"
    private var items: [Character]
    
    var publicKey: String = "505ea7d44709a9e85ef32c69a56cb2c7"
    var privateKey: String = "72f8aaf9a1999ccc0a4e2bbe277db8dba3b98135"
    
    init(presenter: CharactersListPresentable, worker: CharactersListWorkerProtocol) {
        self.presenter = presenter
        self.worker = worker
        self.items = []
    }
    
    func onViewLoad() {
        worker.get(url: url, publicKey: publicKey, privateKey: privateKey) { items in
            self.items = items
            self.presenter.showItems(items: items)
        }
    }
}
