import Foundation
import UIKit

protocol CharacterDetailsPresentable {
    func show(character: Character)
    func show(image: UIImage)
    func show(comics: [Comic])
}

class CharacterDetailsPresenter: CharacterDetailsPresentable {
    private let view: CharacterDetailsView
    
    init(view: CharacterDetailsView) {
        self.view = view
    }

    func show(character: Character) {
        view.show(character: character)
    }
    
    func show(image: UIImage) {
        view.show(image: image)
    }
    
    func show(comics: [Comic]) {
        view.show(comics: comics)
    }
}
