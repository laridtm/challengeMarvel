//
//  CharacterDetailsInteractor.swift
//  challangeMarvel
//
//  Created by Larissa Diniz on 29/07/20.
//  Copyright © 2020 Larissa Diniz. All rights reserved.
//

import Foundation

protocol CharacterDetailsInteractorProtocol {
    func onViewLoad()
}

class CharacterDetailsInteractor: CharacterDetailsInteractorProtocol {
    
    private let presenter: CharacterDetailsPresentable
    private let worker: CharacterDetailsWorkerProtocol
    private var character: Character
    
    
    init(presenter: CharacterDetailsPresentable, worker: CharacterDetailsWorkerProtocol, character: Character) {
        self.presenter = presenter
        self.worker = worker
        self.character = character
    }
    
    func onViewLoad() {
        presenter.show(character: self.character)
        guard let collectionURI = character.comics?.collectionURI else { return }
        worker.getComics(url: collectionURI) { comics in
            self.presenter.show(comics: comics)
        }
    }
}
