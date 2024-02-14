import UIKit

final class PhotoInfoAssembler {
    private init(){ }
       
       static func makePhotoInfoVC(
        coordinator: PhotoInfoCoordinatorProtocol,
        container: Container,
        photo: Photo
       ) -> UIViewController {
           let vc = PhotoInfoVC(
            viewModel: makeViewModel(
                coordinator: coordinator,
                container: container,
                photo: photo
            )
           )
           return vc
       }
       
       private static func makeViewModel(
        coordinator: PhotoInfoCoordinatorProtocol,
        container: Container,
        photo: Photo
       ) -> PhotoInfoVM {
           return PhotoInfoVM(
            coordinator: coordinator,
            imageDownloadService: makeImageDownloadService(container: container),
            networkService: makeNetworkService(container: container),
            parametersService: makeParametersService(container: container),
            photo: photo
           )
       }
    
    private static func makeImageDownloadService(container: Container) -> ImageDownloadServiceProtocol {
        return container.resolve()
    }
    
    private static func makeNetworkService(container: Container) -> NetworkServiceProtocol {
        return container.resolve()
    }
    
    private static func makeParametersService(container: Container) -> ParametersServiceProtocol {
        return container.resolve()
    }
}

