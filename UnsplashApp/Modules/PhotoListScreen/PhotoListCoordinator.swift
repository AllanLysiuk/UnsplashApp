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

extension PhotoListCoordinator: PhotoListCoordinatorProtocol {}
