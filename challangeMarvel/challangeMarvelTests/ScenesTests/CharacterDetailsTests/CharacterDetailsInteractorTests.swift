import XCTest

final class CharacterDetailsInteractorTests: XCTestCase {
    private let workerStub = CharacterDetailsWorkerStub()
    private let presenterSpy = CharacterDetailsPresenterSpy()
    private let parser = MarvelAPIParser()
    private let character = Character(id: 0, name: "testName", description: "testDescription", modified: "", thumbnail: nil, comics: CharacterComicList(available: 0, returned: 0, collectionURI: "", items: []))
    
    private lazy var sut: CharacterDetailsInteractor = {
        return CharacterDetailsInteractor(presenter: presenterSpy, worker: workerStub, character: character, parser: parser)
    }()
    
    func testGetCharacterDetails_WhenWorkerGetSuccess_PresenterShouldShowCharacterDetails() throws {
        let data = try loadDataObject(fromJSON: .characterComics)
        workerStub.result = .success(data)
        
        let comics = parser.parseToComics(data: data)
        
        sut.getCharacterDetails()
        XCTAssertEqual(presenterSpy.didCallShowCharacter, 1)
        XCTAssertEqual(presenterSpy.characterToShowSpy, character)
        
        XCTAssertEqual(presenterSpy.comicsToShowSpy.count, comics?.count)
        XCTAssertEqual(presenterSpy.didCallShowComics, 1)
    }
}
