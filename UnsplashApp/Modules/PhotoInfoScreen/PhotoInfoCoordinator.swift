import UIKit

final class PhotoInfoCoordinator: Coordinator {
    private var rootNavigationController: UINavigationController
    private var rootCoordinator: PhotoInfoRootCoordinatorProtocol
    private var container: Container
    
    var childCoordinators: [Coordinator] = []
    
    init(
        rootNavigationController: UINavigationController,
        rootCoordinator: PhotoInfoRootCoordinatorProtocol,
        container: Container
    ) {
        self.rootNavigationController = rootNavigationController
        self.rootCoordinator = rootCoordinator
        self.container = container
    }
    
    func start() {
        let vc = PhotoInfoAssembler.makePhotoInfoVC(coordinator: self, container: container)
        rootNavigationController.present(vc, animated: true)
    }
    
    func finish() {
        rootCoordinator.photoInfoFinished(self)
    }
}

extension PhotoInfoCoordinator: PhotoInfoCoordinatorProtocol {
    func finish(shouldMoveToParent: Bool) {
        if shouldMoveToParent {
            rootNavigationController.dismiss(animated: true)
        }
        finish()
    }
}
