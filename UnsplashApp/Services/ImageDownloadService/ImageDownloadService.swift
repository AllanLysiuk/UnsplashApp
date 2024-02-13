import UIKit

final class ImageDownloadService: ImageDownloadServiceProtocol {
    
    private var cache: ImageCacheService
    
    private var currentTask: URLSessionDownloadTask?
    private var currentRequest: URLRequest?
    
    init(cache: ImageCacheService) {
        self.cache = cache
    }
    
    func downloadImage(from urlStr: URL,
                       completion: @escaping (Result<UIImage?, Error>) -> Void) {
        if let cachedImage = cache.get(for: urlStr.absoluteString) {
            completion(.success(cachedImage))
            return
        }
        
        var request = URLRequest(url: urlStr)
        request.timeoutInterval = 5
        request.httpMethod = HTTPMethod.get.rawValue
        
        currentRequest = request
        
        URLSession.shared.downloadTask(with: request)
        { [weak self] fileURL, response, error in
            guard let self = self else { return }
            
            if let error = error {
                completion(.failure(error))
            } else if let response = response,
                      response.url == self.currentRequest?.url,
                      let fileUrl = fileURL {
                if let data = try? Data(contentsOf: fileUrl),
                   let image = UIImage(data: data) {
                    self.cache.set(value: image, for: urlStr.absoluteString)
                    completion(.success(image))
                }
            }
        }.resume()
    }
    
    func cancelCurrentDownload() {
        currentTask?.cancel()
        currentRequest = nil
    }
}
