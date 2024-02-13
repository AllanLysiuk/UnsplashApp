import UIKit

final class TabBarCoordinator: Coordinator,
                               TabBarCoordinatorProtocol {

    private var rootNavigationController: UINavigationController
    private var rootCoordinator: TabBarRootCoordinatorProtocol
    private var container: Container
    var childCoordinators: [Coordinator] = []
    
    init(
        rootNavigationController: UINavigationController,
        rootCoordinator: TabBarRootCoordinatorProtocol,
        container: Container
    ) {
        self.rootNavigationController = rootNavigationController
        self.rootCoordinator = rootCoordinator
        self.container = container
    }
    
    func start() {
        let vc = TabBarAssembler.makeTabBarController(coordinator: self)
        
        generatePhotoListItem(tabBar: vc)
        generateFavoritePhotoListItem(tabBar: vc)
        rootNavigationController.navigationBar.isHidden = true
        rootNavigationController.pushViewController(vc, animated: false)
    }
    
    func finish() {
        rootNavigationController.popViewController(animated: false)
        rootCoordinator.finished(self)
    }
    
    private func generatePhotoListItem(tabBar: UITabBarController) {
        let coordinator = PhotoListCoordinator(tabBarController: tabBar, rootCoordinator: self, container: container)
        childCoordinators.append(coordinator)
        coordinator.start()
    }
    
    private func generateFavoritePhotoListItem(tabBar: UITabBarController) {
        let coordinator = FavPhotoListCoordinator(tabBarController: tabBar, rootCoordinator: self, container: container)
        childCoordinators.append(coordinator)
        coordinator.start()
    }
    
}

extension TabBarCoordinator: PhotoListRootCoordinatorProtocol {
    func photoListVCFinished(_ coordinator: Coordinator) {
        childCoordinators.removeAll { tmp in
            tmp === coordinator
        }
    }
}

extension TabBarCoordinator: FavPhotosListRootCoordinatorProtocol {
    func favPhotoListVCFinished(_ coordinator: Coordinator) {
        childCoordinators.removeAll { tmp in
            tmp === coordinator
        }
    }
}
