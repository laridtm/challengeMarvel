import XCTest

final class CharactersDetailsFactoryTests: XCTestCase {
    func testMake_ShouldReturnTheRightViewController() {
        let character = Character(id: 0, name: "", description: "", modified: "", thumbnail: nil, comics: nil)
        let viewController = CharacterDetailsFactory.make(character: character)

        XCTAssertTrue(viewController is CharacterDetailsViewController)
    }
}
