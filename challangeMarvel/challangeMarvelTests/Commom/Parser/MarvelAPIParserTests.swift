import XCTest

final class MarvelAPIParserTests: XCTestCase {
    private lazy var sut: MarvelAPIParser = {
        let parser = MarvelAPIParser()
        return parser
    }()
    
    func testParserToCharacters_WithSucessData_ShouldReturnCharacters() throws {
        let data = try loadDataObject(fromJSON: .characterList)
        
        let characters = sut.parseToCharacters(data: data)
        
        XCTAssertEqual(characters?.count, 100)
    }
    
    func testParserToComics_WithSucessData_ShouldReturnComics() throws {
        let data = try loadDataObject(fromJSON: .characterComics)
        
        let comics = sut.parseToComics(data: data)
        
        XCTAssertEqual(comics?.count, 4)
    }
}
