import UIKit

final class ImageDownloadCellVM: ImageDownloadCellVMProtocol {
    
    private var imageDownloadService: ImageDownloadServiceProtocol
    
    init(imageDownloadService: ImageDownloadServiceProtocol) {
        self.imageDownloadService = imageDownloadService
    }
    
    func prepareForReuse() {
        imageDownloadService.cancelCurrentDownload()
    }
    
    func loadImage(by url: URL, completion: @escaping (UIImage?) -> Void) {
        imageDownloadService.downloadImage(from: url) { result in
            switch result {
            case .failure(let error):
                print(error)
                DispatchQueue.main.async {
                    completion(UIImage(named: "noImage"))
                }
            case .success(let image):
                DispatchQueue.main.async {
                    completion(image)
                }
            }
        }
    }
    
    
    
    
}
