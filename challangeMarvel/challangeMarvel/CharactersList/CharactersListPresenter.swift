import Foundation

protocol CharactersListPresentable {
    func show(items: [Character])
    func append(items: [Character])
}

class CharactersListPresenter: CharactersListPresentable {
    let view: CharactersListView
    
    init(view: CharactersListView) {
        self.view = view
    }

    func show(items: [Character]) {
        view.show(items: items)
    }
    
    func append(items: [Character]) {
        view.append(items: items)
    }
}
