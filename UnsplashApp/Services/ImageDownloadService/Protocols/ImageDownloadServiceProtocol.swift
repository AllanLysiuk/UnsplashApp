import UIKit

protocol ImageDownloadServiceProtocol: AnyObject {
    
    func downloadImage(from urlStr: URL,
                       completion: @escaping (Result<UIImage?, Error>) -> Void)
    func cancelCurrentDownload()
}
