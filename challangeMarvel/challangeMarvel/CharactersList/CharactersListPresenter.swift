//
//  CharactersListPresenter.swift
//  challangeMarvel
//
//  Created by Larissa Diniz on 28/07/20.
//  Copyright © 2020 Larissa Diniz. All rights reserved.
//

import Foundation

protocol CharactersListPresentable: class {
    var view: CharactersListView? { get }
    func show(items: [Character])
    func append(items: [Character])
}

class CharactersListPresenter: CharactersListPresentable {
    
    internal weak var view: CharactersListView?
    
    init(view: CharactersListView) {
        self.view = view
    }

    func show(items: [Character]) {
        view?.show(items: items)
    }
    
    func append(items: [Character]) {
        view?.append(items: items)
    }
}
