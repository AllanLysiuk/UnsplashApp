import UIKit

final class PhotoListAssembler {
    private init(){ }
       
       static func makePhotoListVC(
        coordinator: PhotoListCoordinatorProtocol,
        container: Container
       ) -> UIViewController {
           let vc = PhotoListVC(
            viewModel: makeViewModel(
                coordinator: coordinator,
                container: container
            )
           )
           return vc
       }
       
       private static func makeViewModel(
        coordinator: PhotoListCoordinatorProtocol,
        container: Container
       ) -> PhotoListVM {
           return PhotoListVM(
            coordinator: coordinator
           )
       }
}
