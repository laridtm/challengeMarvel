import XCTest

final class CharactersListInteractorTests: XCTestCase {
    private let workerStub = CharacterListWorkerStub()
    private let presenterSpy = CharacterListPresenterSpy()
    private let parser = MarvelAPIParser()
    
    private lazy var sut: CharactersListInteractor = {
        CharactersListInteractor(presenter: presenterSpy, worker: workerStub, parser: parser)
    }()
    
    func testGetCharacters_WhenWorkerGetSuccess_PresenterShouldShowCharacters() throws {
        let data = try loadDataObject(fromJSON: .characterList)
        workerStub.result = .success(data)
        
        let characters = parser.parseToCharacters(data: data)
        
        sut.getCharacters()
        XCTAssertEqual(presenterSpy.itemsToShowSpy.count, characters?.count)
        XCTAssertEqual(presenterSpy.didCallShowItems, 1)
    }
    
    func testGetMoreCharacters_WhenWorkerGetSuccess_PresenterShouldAppendCharacters() throws {
        let data = try loadDataObject(fromJSON: .characterList)
        workerStub.result = .success(data)
        
        let characters = parser.parseToCharacters(data: data)
        
        sut.getCharacters()
        XCTAssertEqual(presenterSpy.itemsToShowSpy.count, characters?.count)
        XCTAssertEqual(presenterSpy.didCallShowItems, 1)
        
        sut.getMoreCharacters()
        let count = characters?.count ?? 0
        XCTAssertEqual(presenterSpy.itemsToShowSpy.count, 2 * count)
        XCTAssertEqual(presenterSpy.didCallShowItems, 2)
    }
}
