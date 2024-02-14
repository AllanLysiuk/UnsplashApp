import UIKit

final class PhotoInfoVM: PhotoInfoVMProtocol {
    private weak var coordinator: PhotoInfoCoordinatorProtocol?
    private var imageDownloadService: ImageDownloadServiceProtocol
    
    var photo: Photo
    
    init(
        coordinator: PhotoInfoCoordinatorProtocol,
        imageDownloadService: ImageDownloadServiceProtocol,
        photo: Photo
    ) {
        self.coordinator = coordinator
        self.imageDownloadService = imageDownloadService
        self.photo = photo
    }
    
    func downloadImage(completion: @escaping (Result<UIImage?, Error>) -> Void) {
        imageDownloadService.downloadImage(from: photo.urls.url, completion: completion)
    }
    
    func finish(shouldMoveToParent: Bool) {
        coordinator?.finish(shouldMoveToParent: shouldMoveToParent)
    }
}

