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
    private let parser: MarvelAPIParserProtocol
    
    init(presenter: CharactersListPresentable,
         worker: CharactersListWorkerProtocol,
         parser: MarvelAPIParserProtocol = MarvelAPIParser()) {
        self.presenter = presenter
        self.worker = worker
        self.parser = parser
        self.items = []
    }
    
    func getCharacters() {
        worker.getCharacters(url: url,
                             paginationParameters: parser.paginationParameters) { result in
            self.handleCharactersRequest(result)
        }
    }
    
    func getMoreCharacters() {
        let total = parser.paginationParameters.total
        if total == 0 || parser.paginationParameters.count < total {
           getCharacters()
        }
    }
}

private extension CharactersListInteractor {
    func handleCharactersRequest(_ result: Result<Data, Error>) {
        switch result {
        case .success(let response):
            guard let characters = parser.parseToCharacters(data: response) else {
                //TODO: Mostrar erro na view
                return
            }
            
            if self.items.isEmpty {
                self.items = characters
                presenter.show(items: characters)
            } else {
                self.items.append(contentsOf: characters)
                self.presenter.append(items: characters)
            }
        case .failure(let error):
            print("HandlerCharacterRequestError: \(error)")
            //TODO: Mostrar erro na view
        }
    }
}
