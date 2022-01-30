import XCTest

extension XCTestCase {
    enum TestError: Error {
        case invalidJson
        case fileNotFound
    }
    
    func loadDataObject(fromJSON fileName: FileName) throws -> Data {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: fileName.rawValue, withExtension: "json") else {
            XCTFail("Missing File: \(fileName.rawValue).json")
            throw TestError.fileNotFound
        }
        do {
            return try Data(contentsOf: url)
        } catch {
            throw error
        }
    }
}
