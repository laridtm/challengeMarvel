//
//  CharactersListInteractor.swift
//  challangeMarvel
//
//  Created by Larissa Diniz on 28/07/20.
//  Copyright © 2020 Larissa Diniz. All rights reserved.
//

import Foundation

protocol CharactersListInteractorProtocol {
    
}

class CharactersListInteractor: CharactersListInteractorProtocol {
    private let presenter: CharactersListPresentable
    private let worker: CharactersListWorkerProtocol
    
    init(presenter: CharactersListPresentable, worker: CharactersListWorkerProtocol) {
        self.presenter = presenter
        self.worker = worker
    }
    
}
