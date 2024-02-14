import UIKit

final class PhotoListCoordinator: Coordinator {
    
    private var tabBarController: UITabBarController
    private var rootCoordinator: PhotoListRootCoordinatorProtocol
    private var container: Container
    private var navigationController = UINavigationController()
    
    var childCoordinators: [Coordinator] = []
    
    init(
        tabBarController: UITabBarController,
        rootCoordinator: PhotoListRootCoordinatorProtocol,
        container: Container
    ) {
        self.tabBarController = tabBarController
        self.rootCoordinator = rootCoordinator
        self.container = container
    }
    
    func start() {
        let vc = PhotoListAssembler.makePhotoListVC(coordinator: self, container: container)
        navigationController.addChild(vc)
        tabBarController.addChild(navigationController)
    }
    
    func finish() {
        tabBarController.removeFromParent()
        rootCoordinator.photoListVCFinished(self)
    }
    
}

extension PhotoListCoordinator: PhotoListCoordinatorProtocol {
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

extension PhotoListCoordinator: PhotoInfoRootCoordinatorProtocol {
    func photoInfoFinished(_ coordinator: Coordinator) {
        childCoordinators.removeAll { tmp in
            tmp === coordinator
        }
    }
}
