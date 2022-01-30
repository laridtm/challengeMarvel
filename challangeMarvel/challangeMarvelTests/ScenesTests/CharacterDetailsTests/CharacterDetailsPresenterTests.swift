import XCTest

final class CharacterDetailsPresenterTests: XCTestCase {
    private let viewControllerSpy = CharacterDetailsViewControllerSpy()
    private let parser = MarvelAPIParser()
    
    private lazy var sut: CharacterDetailsPresenter = {
        let presenter = CharacterDetailsPresenter(view: viewControllerSpy)
        return presenter
    }()
    
    func testPresentSuccess_WhenReceiveRequestedShowCharacter_ShouldUpdateViewControllerWithCharacter() throws {
        let character = Character(id: 0, name: "testName", description: "testDescription", modified: "", thumbnail: nil, comics: nil)
        
        sut.show(character: character)
        
        XCTAssertEqual(viewControllerSpy.didCallShowCharacter, 1)
        XCTAssertEqual(viewControllerSpy.characterToShowSpy, character)
    }
    
    func testPresentSuccess_WhenReceiveRequestedShowComics_ShouldUpdateViewControllerWithComics() throws {
        let data = try loadDataObject(fromJSON: .characterComics)
        guard let comics = parser.parseToComics(data: data) else {
            XCTFail("Error parsing data to character")
            return
        }
        
        sut.show(comics: comics)
        
        XCTAssertEqual(viewControllerSpy.didCallShowComics, 1)
        XCTAssertEqual(viewControllerSpy.comicsToShowSpy.count, comics.count)
    }
}
