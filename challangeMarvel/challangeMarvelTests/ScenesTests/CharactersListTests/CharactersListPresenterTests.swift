import XCTest

final class CharactersListPresenterTests: XCTestCase {
    private let viewControllerSpy = CharacterListViewControllerSpy()
    private let parser = MarvelAPIParser()
    
    private lazy var sut: CharactersListPresenter = {
        let presenter = CharactersListPresenter(view: viewControllerSpy)
        return presenter
    }()
    
    func testPresentSuccess_WhenReceiveRequestedGetCharacters_ShouldUpdateViewControllerWithCharacters() throws {
        let data = try loadDataObject(fromJSON: .characterList)
        guard let characters = parser.parseToCharacters(data: data) else {
            XCTFail("Error parsing data to character")
            return
        }
        
        sut.show(items: characters)
        
        XCTAssertEqual(viewControllerSpy.itemsToShowSpy.count, characters.count)
        XCTAssertEqual(viewControllerSpy.didCallShowItems, 1)
    }
}
