import XCTest

final class CharactersListFactoryTests: XCTestCase {
    func testMake_ShouldReturnTheRightViewController() {
        let viewController = CharacterListFactory.make()

        XCTAssertTrue(viewController is CharactersListViewController)
    }
}
