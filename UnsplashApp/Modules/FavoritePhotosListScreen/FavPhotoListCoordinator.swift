import UIKit

final class FavPhotoListCoordinator: Coordinator {
    
    private var tabBarController: UITabBarController
    private var rootCoordinator: FavPhotosListRootCoordinatorProtocol
    private var container: Container
    private var navigationController = UINavigationController()
    
    var childCoordinators: [Coordinator] = []
    
    init(
        tabBarController: UITabBarController,
        rootCoordinator: FavPhotosListRootCoordinatorProtocol,
        container: Container
    ) {
        self.tabBarController = tabBarController
        self.rootCoordinator = rootCoordinator
        self.container = container
    }
    
    func start() {
        let vc = FavPhotosListAssembler.makeFavPhotoListVC(coordinator: self, container: container)
        navigationController.addChild(vc)
        tabBarController.addChild(navigationController)
    }
    
    func finish() {
        tabBarController.removeFromParent()
        rootCoordinator.favPhotoListVCFinished(self)
    }
    
}

extension FavPhotoListCoordinator: FavPhotosListCoordinatorProtocol {
    func showPhotoInfoVC(for photo: Photo) {
        let coordinator = PhotoInfoCoordinator(
            rootNavigationController: navigationController,
            rootCoordinator: self,
            container: container
        )
        childCoordinators.append(coordinator)
        coordinator.start(with: photo)
    }
}

extension FavPhotoListCoordinator: PhotoInfoRootCoordinatorProtocol {
    func photoInfoFinished(_ coordinator: Coordinator) {
        childCoordinators.removeAll { tmp in
            tmp === coordinator
        }
    }
}

