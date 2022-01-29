import XCTest

class AuthenticationTests: XCTestCase {
    func testMd5Algorithm() {
        let hash = "2c3e9759605f5af4cec4035f0eb3078c"
        let hashResult = Authentication.MD5(string: "myPrivateKey")
        XCTAssertEqual(hash, hashResult)
    }
}
