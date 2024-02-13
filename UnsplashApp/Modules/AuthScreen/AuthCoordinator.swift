import UIKit

final class AuthCoordinator: Coordinator {
    private var rootNavigationController: UINavigationController
    private var rootCoordinator: AuthRootCoordinatorProtocol
    private var container: Container
    
    var childCoordinators: [Coordinator] = []
    
    init(
        rootNavigationController: UINavigationController,
        rootCoordinator: AuthRootCoordinatorProtocol,
        container: Container
    ) {
        self.rootNavigationController = rootNavigationController
        self.rootCoordinator = rootCoordinator
        self.container = container
    }
    
    func start() {
        let vc = AuthAssembler.makeAuthVC(coordinator: self, container: container)
        rootNavigationController.pushViewController(vc, animated: false)
    }
    
    func finish() {
        rootNavigationController.popToRootViewController(animated: true)
        rootCoordinator.authFinished(self)
    }
}

extension AuthCoordinator: AuthCoordinatorProtocol {}
