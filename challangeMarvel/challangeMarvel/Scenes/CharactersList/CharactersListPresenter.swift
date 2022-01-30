import Foundation

protocol CharactersListPresentable {
    func show(items: [Character])
}

final class CharactersListPresenter: CharactersListPresentable {
    let view: CharactersListView
    
    init(view: CharactersListView) {
        self.view = view
    }

    func show(items: [Character]) {
        view.show(items: items)
    }
}
