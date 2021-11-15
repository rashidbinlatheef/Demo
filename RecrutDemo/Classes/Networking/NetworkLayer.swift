import Foundation


typealias NetworkTaskCompletion = (URLRequest?, URLResponse?, Data?, Error?) -> Void

struct NetworkLayer {
    
    enum RequestMethod: String {
        case GET, POST, PUT, DELETE
    }
    
    static let sharedInstance = NetworkLayer()
    var session: URLSession {
        return URLSession(configuration: .default)
    }
    
    private init() {
        
    }
    
    fileprivate func httpMethodString(for method: RequestMethod) -> String {
        return method.rawValue
    }
    
    fileprivate func resumeTask(with request: URLRequest, completion: @escaping NetworkTaskCompletion) {
        
        let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error) -> Void in
            
            completion(request, response, data, error)
            
        })
        task.resume()
    }
}

extension NetworkLayer {
    
    private func request(with urlString: String) -> URLRequest? {
        
        guard let escapedUrlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return nil
        }
        
        guard let requestURL = URL(string: escapedUrlString) else {
            return nil
        }
        return URLRequest(url: requestURL)
    }
    
    //MARK: GET
    func get(url: String, completion: @escaping NetworkTaskCompletion) {
        
        guard var request = request(with: url) else {
            completion(nil, nil, nil, nil)
            return
        }
        request.httpMethod = httpMethodString(for: .GET)
        resumeTask(with: request as URLRequest, completion: completion)
    }
    
    //MARK: Download file
    func downloadFile(from url: URL, completion: @escaping (_ locationURL: URL?, _ response:URLResponse?, _ error: Error?) -> Void) {
        
        //debugPrint("^-----Download \(url)")
        
        let downloadTask = session.downloadTask(with: url) { (locationURL, response, error) -> Void in
            
            completion(locationURL, response, error)
            return
        }
        
        downloadTask.resume()
    }
}





























