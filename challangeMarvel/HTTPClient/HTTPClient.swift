import Foundation

typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void

protocol URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol?
}

protocol URLSessionDataTaskProtocol {
    func resume()
}

class HTTPClient {
    private let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func get(url: URL, completion: @escaping(Result<Data, Error>) -> Void) {
        let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            } else if let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) {
                guard let data = data else { return }
                completion(.success(data))
            } else {
                completion(.failure(NSError(domain: "Error Status Code", code: 0, userInfo: nil)))
            }
        })
        task?.resume()
    }
}

extension URLSession: URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol? {
        return (dataTask(with: url, completionHandler: completionHandler) as URLSessionDataTask) as URLSessionDataTaskProtocol
    }
}

extension URLSessionDataTask: URLSessionDataTaskProtocol { }

