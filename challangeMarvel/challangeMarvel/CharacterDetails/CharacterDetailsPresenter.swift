//
//  CharacterDetailsPresenter.swift
//  challangeMarvel
//
//  Created by Larissa Diniz on 29/07/20.
//  Copyright © 2020 Larissa Diniz. All rights reserved.
//

import Foundation
import UIKit

protocol CharacterDetailsPresentable: class {
    var view: CharacterDetailsView? { get }
    func show(character: Character)
    func show(image: UIImage)
    func show(comics: [Comic])
}

class CharacterDetailsPresenter: CharacterDetailsPresentable {
    
    internal weak var view: CharacterDetailsView?
    
    init(view: CharacterDetailsView) {
        self.view = view
    }

    func show(character: Character) {
        view?.show(character: character)
    }
    
    func show(image: UIImage) {
        view?.show(image: image)
    }
    
    func show(comics: [Comic]) {
        view?.show(comics: comics)
    }
}
