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
            photo: photo
           )
       }
    
    private static func makeImageDownloadService(container: Container) -> ImageDownloadServiceProtocol {
        return container.resolve()
    }
}

