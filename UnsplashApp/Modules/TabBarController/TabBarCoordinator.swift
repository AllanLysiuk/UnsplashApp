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
        
        generateHomeItem(tabBar: vc)
        generateHistoryItem(tabBar: vc)
        rootNavigationController.navigationBar.isHidden = true
        rootNavigationController.pushViewController(vc, animated: false)
    }
    
    func finish() {
        rootNavigationController.popViewController(animated: false)
        rootCoordinator.finished(self)
    }
    
    private func generateHomeItem(tabBar: UITabBarController) {
//        let coordinator = HomePageCoordinator(tabBarController: tabBar, rootCoordinator: self, container: container)
//        childCoordinators.append(coordinator)
//        coordinator.start()
    }
    
    private func generateHistoryItem(tabBar: UITabBarController) {
//        let coordinator = HistoryVCCoordinator(tabBarController: tabBar, rootCoordinator: self)
//        childCoordinators.append(coordinator)
//        coordinator.start()
    }
    
}

//extension TabBarCoordinator: HomePageRootCoordinatorProtocol {
//    func homePageFinished(_ coordinator: Coordinator) {
//        childCoordinators.removeAll { tmp in
//            tmp === coordinator
//        }
//    }
//}
//
//extension TabBarCoordinator: CurrencyRootCoordinatorProtocol {
//    func finish(_ coordinator: Coordinator) {
//        childCoordinators.removeAll { tmp in
//            tmp === coordinator
//        }
//    }
//}
