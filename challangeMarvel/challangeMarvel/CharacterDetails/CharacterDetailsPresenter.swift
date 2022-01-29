import Foundation
import UIKit

protocol CharacterDetailsPresentable {
    func show(character: Character)
    func show(comics: [Comic])
}

final class CharacterDetailsPresenter: CharacterDetailsPresentable {
    private let view: CharacterDetailsView
    
    init(view: CharacterDetailsView) {
        self.view = view
    }

    func show(character: Character) {
        view.show(character: character)
    }
    
    func show(comics: [Comic]) {
        view.show(comics: comics)
    }
}
