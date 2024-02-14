import UIKit

final class PhotoInfoVM: PhotoInfoVMProtocol {
    private weak var coordinator: PhotoInfoCoordinatorProtocol?
    private var imageDownloadService: ImageDownloadServiceProtocol
    private var networkService: PhotoInfoNetworkServiceProtocol
    private var parametersService: PhotoInfoParamServiceProtocol
    
    var photo: Photo
    
    init(
        coordinator: PhotoInfoCoordinatorProtocol,
        imageDownloadService: ImageDownloadServiceProtocol,
        networkService: PhotoInfoNetworkServiceProtocol,
        parametersService: PhotoInfoParamServiceProtocol,
        photo: Photo
    ) {
        self.coordinator = coordinator
        self.imageDownloadService = imageDownloadService
        self.networkService = networkService
        self.parametersService = parametersService
        self.photo = photo
    }
    
    func downloadImage(completion: @escaping (Result<UIImage?, Error>) -> Void) {
        imageDownloadService.downloadImage(from: photo.urls.url, completion: completion)
    }
    
    func likeAPhoto() {
        guard let userToken = parametersService.getUserAccessToken() else {
            //TODO: add error
            return
        }
        networkService.likeAPhoto(userToken: userToken, id: photo.id) { error in
            if error.isNotNil {
                //TODO: add error handling
                print(error?.localizedDescription)
            }
        }
    }
    
    func unlikeAPhoto() {
        guard let userToken = parametersService.getUserAccessToken() else {
            //TODO: add error
            return
        }
        networkService.unlikeAPhoto(userToken: userToken, id: photo.id) { error in
            if error.isNotNil {
                //TODO: add error handling
                print(error?.localizedDescription)
            }
        }
    }
    
    func finish(shouldMoveToParent: Bool) {
        coordinator?.finish(shouldMoveToParent: shouldMoveToParent)
    }
}

