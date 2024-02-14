import UIKit

final class FavPhotosListAssembler {
    private init(){ }
       
       static func makeFavPhotoListVC(
        coordinator: FavPhotosListCoordinatorProtocol,
        container: Container
       ) -> UIViewController {
           let vc = FavPhotosListVC(
            viewModel: makeViewModel(
                coordinator: coordinator,
                container: container
            )
           )
           return vc
       }
       
       private static func makeViewModel(
        coordinator: FavPhotosListCoordinatorProtocol,
        container: Container
       ) -> FavPhotosListVM {
           return FavPhotosListVM(
            coordinator: coordinator,
            networkService: makeNetworkService(container: container)
           )
       }
    
    private static func makeNetworkService(container: Container) -> NetworkServiceProtocol {
        return container.resolve()
    }
}
