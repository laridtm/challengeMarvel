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
}

final class CharactersListPresenter: CharactersListPresentable {
    
    internal weak var view: CharactersListView?
    
    init(view: CharactersListView) {
        self.view = view
    }

}
