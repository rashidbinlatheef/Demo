import Foundation

/// Service which executes network request
protocol NetworkService {
    /// Execute request with given url and method
    ///
    /// - Parameters:
    ///   - urlString: The url of the network request
    ///   - method: The Request method
    ///   - completion: The Request response in `NetworkTaskCompletion`
    func executeRequestWith(
        urlString: String,
        method: RequestMethod,
        completion: @escaping NetworkTaskCompletion
    )
    
    /// Download file from  given url
    ///
    /// - Parameters:
    ///   - url: The location of the file
    ///   - completion: The Download file response
    func downloadFile(
        from url: URL,
        completion: @escaping (_ locationURL: URL?, _ response:URLResponse?, _ error: Error?) -> Void
    )
}

enum RequestMethod: String {
    case GET, POST, PUT, DELETE
}

typealias NetworkTaskCompletion = (URLRequest?, URLResponse?, Data?, Error?) -> Void

struct NetworkLayer {
    static let sharedInstance = NetworkLayer()
    private var session: URLSession = URLSession(configuration: .default)
    
    private init() {
    }
}

// MARK: - Private

private extension NetworkLayer {
    func resumeTask(with request: URLRequest, completion: @escaping NetworkTaskCompletion) {
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            completion(request, response, data, error)
        })
        task.resume()
    }
    
    func request(with urlString: String) -> URLRequest? {
        guard let escapedUrlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let requestURL = URL(string: escapedUrlString) else {
                  return nil
              }
        return URLRequest(url: requestURL)
    }
}

// MARK: - Networking

extension NetworkLayer: NetworkService {
    func executeRequestWith(
        urlString: String,
        method: RequestMethod,
        completion: @escaping NetworkTaskCompletion
    ) {
        guard var request = request(with: urlString) else {
            completion(nil, nil, nil, nil)
            return
        }
        request.httpMethod = method.rawValue
        resumeTask(with: request, completion: completion)
    }
    
    func downloadFile(
        from url: URL,
        completion: @escaping (_ locationURL: URL?, _ response:URLResponse?, _ error: Error?) -> Void
    ) {
        let downloadTask = session.downloadTask(with: url) { locationURL, response, error -> Void in
            completion(locationURL, response, error)
            return
        }
        downloadTask.resume()
    }
}
