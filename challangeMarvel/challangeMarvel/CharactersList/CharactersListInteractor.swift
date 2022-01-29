import Foundation

protocol CharactersListInteractorProtocol {
    func getCharacters()
    func getMoreCharacters()
}

final class CharactersListInteractor: CharactersListInteractorProtocol {
    private let presenter: CharactersListPresentable
    private let worker: CharactersListWorkerProtocol
    private var url: String = "http://gateway.marvel.com/v1/public/characters"
    private var items: [Character]
    
    init(presenter: CharactersListPresentable, worker: CharactersListWorkerProtocol) {
        self.presenter = presenter
        self.worker = worker
        self.items = []
    }
    
    func getCharacters() {
        worker.get(url: url) { items in
            self.items = items
            self.presenter.show(items: items)
        }
    }
    
    func getMoreCharacters() {
        worker.getMore(url: url) { items in
            self.items.append(contentsOf: items)
            self.presenter.append(items: items)
        }
    }
}
