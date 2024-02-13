import UIKit

final class PhotoInfoAssembler {
    private init(){ }
       
       static func makePhotoInfoVC(
        coordinator: PhotoInfoCoordinatorProtocol,
        container: Container
       ) -> UIViewController {
           let vc = PhotoInfoVC(
            viewModel: makeViewModel(
                coordinator: coordinator,
                container: container
            )
           )
           return vc
       }
       
       private static func makeViewModel(
        coordinator: PhotoInfoCoordinatorProtocol,
        container: Container
       ) -> PhotoInfoVM {
           return PhotoInfoVM(
            coordinator: coordinator
           )
       }
    
}

