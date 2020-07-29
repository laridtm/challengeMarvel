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
    func loadMoreData()
}

class CharactersListInteractor: CharactersListInteractorProtocol {
    
    private let presenter: CharactersListPresentable
    private let worker: CharactersListWorkerProtocol
    var url: String = "http://gateway.marvel.com/v1/public/characters"
    private var items: [Character]
    
    init(presenter: CharactersListPresentable, worker: CharactersListWorkerProtocol) {
        self.presenter = presenter
        self.worker = worker
        self.items = []
    }
    
    func onViewLoad() {
        worker.get(url: url) { items in
            self.items = items
            self.presenter.show(items: items)
        }
    }
    
    func loadMoreData() {
        worker.getMore(url: url) { items in
            self.items.append(contentsOf: items)
            self.presenter.append(items: items)
        }
    }
}
