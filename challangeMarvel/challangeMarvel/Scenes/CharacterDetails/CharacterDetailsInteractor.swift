import Foundation

protocol CharacterDetailsInteractorProtocol {
    func getCharacterDetails()
}

final class CharacterDetailsInteractor: CharacterDetailsInteractorProtocol {
    private let presenter: CharacterDetailsPresentable
    private let worker: CharacterDetailsWorkerProtocol
    private var character: Character
    private let parser: MarvelAPIParserProtocol
    
    
    init(presenter: CharacterDetailsPresentable,
         worker: CharacterDetailsWorkerProtocol,
         character: Character,
         parser: MarvelAPIParserProtocol = MarvelAPIParser()) {
        self.presenter = presenter
        self.worker = worker
        self.character = character
        self.parser = parser
    }
    
    func getCharacterDetails() {
        presenter.show(character: self.character)
        guard let collectionURI = character.comics?.collectionURI else { return }
        worker.getComics(url: collectionURI) { result in
            self.handleComicsRequest(result)
        }
    }
}

private extension CharacterDetailsInteractor {
    func handleComicsRequest(_ result: Result<Data, Error>) {
        switch result {
        case .success(let response):
            guard let comics = parser.parseToComics(data: response) else {
                //TODO: Mostrar erro na view
                return
            }
            presenter.show(comics: comics)
        case .failure(let error):
            print("HandlerComicsRequestError: \(error)")
            //TODO: Mostrar erro na view
        }
    }
}
