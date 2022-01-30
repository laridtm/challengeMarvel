import XCTest

final class HTTPClientTests: XCTestCase {
    private var subject: HTTPClient?
    private let session = MockURLSession()
    private var url: URL?
    
    override func setUp() {
        super.setUp()
        url = URL(string: "http://masilotti.com")
        subject = HTTPClient(session: session)
    }
    
    override func tearDownWithError() throws {
        subject = nil
        url = nil
    }
    
    func testRequestedURL() {
        guard let url = url else { return }
        
        subject?.get(url: url) { result -> Void in }
        
        XCTAssertEqual(session.lastURL, url)
    }
    
    func testGet_WithSuccessData_ShouldReturnData() {
        guard let url = url else { return }
        session.nextResponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        let expect = expectation(description: "Wait for \(url) to load.")
        var data: Data?
        
        subject?.get(url: url) { result -> Void in
            switch result {
            case .failure:
                break
            case .success(let theData):
                data = theData
                break
            }
            
            expect.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertNotNil(data)
    }
    
    func testGet_WithErrorData_ShouldReturnError() {
        guard let urlError = URL(string: "errorTest") else { return }
        let expect = expectation(description: "Wait for \(urlError) to load.")
        var error: Error?
        
        subject?.get(url: urlError) { result -> Void in
            switch result {
            case .failure(let theError):
                error = theError
            case .success:
                break
            }
            
            expect.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertNotNil(error)
    }
    
    func testGet_WithStatusCodeLessThan200_ShouldReturnError() {
        guard let url = url else { return }
        session.nextResponse = HTTPURLResponse(url: url, statusCode: 199, httpVersion: nil, headerFields: nil)
        
        var error: Error?
        subject?.get(url: url) { result -> Void in
            switch result {
            case .failure(let theError):
                error = theError
            case .success:
                break
            }
        }
        
        XCTAssertNotNil(error)
    }
    
    func testGet_WithStatusCodeGreaterThan299_ShouldReturnError() {
        guard let url = url else { return }
        session.nextResponse = HTTPURLResponse(url: url, statusCode: 300, httpVersion: nil, headerFields: nil)
        
        var error: Error?
        subject?.get(url: url) { result -> Void in
            switch result {
            case .failure(let theError):
                error = theError
            case .success:
                break
            }
        }
        
        XCTAssertNotNil(error)
    }
}

final class MockURLSession: URLSessionProtocol {
    private (set) var lastURL: URL?
    let nextDataTask = MockURLSessionDataTask()
    var nextData: Data?
    var nextError: NSError?
    var nextResponse: HTTPURLResponse?
    
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol? {
        let urlString: String = url.absoluteString
        if urlString != "errorTest" {
            if (200...299).contains(nextResponse?.statusCode ?? 0) {
                nextData = Data()
                nextError = nil
            } else {
                nextError = NSError(domain: "responseError", code: 0, userInfo: nil)
                nextData = nil
            }
        } else {
            nextError = NSError(domain: "error", code: 0, userInfo: nil)
            nextData = nil
        }
        lastURL = url
        completionHandler(nextData, nextResponse, nextError)
        return nextDataTask
    }
}

final class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    private (set) var resumeWasCalled = false
    
    func resume() {
        resumeWasCalled = true
    }
}
