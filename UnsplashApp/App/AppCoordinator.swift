import UIKit

final class AppCoordinator: Coordinator {
    private var windowScene: UIWindowScene
    private var window: UIWindow?
    var childCoordinators: [Coordinator] = []
    
    private var container: Container = {
        let container = Container()
        ServiceConfigurations.configure(container: container)
        return container
    }()
    
    private var parametersService: AppCoordinatorParametersServiceProtocol?
    
    init (windowScene: UIWindowScene) {
        self.windowScene = windowScene
    }
    
    func start() {
        if parametersService.isNil {
            parametersService = makeParametersService()
        }
        
        if let paramService = parametersService {
            if paramService.isUserLoggedIn() {
                openMainScene()
            } else {
                openAuthScene()
            }
        }
    }
    
    func finish() {

    }
    
    private func openAuthScene() {
        let authWindow = UIWindow(windowScene: windowScene)
        let nc = UINavigationController()
        authWindow.rootViewController = nc
        authWindow.makeKeyAndVisible()
        
        let authCoordinator = AuthCoordinator(rootNavigationController: nc, rootCoordinator: self, container: container)
        childCoordinators.append(authCoordinator)
        authCoordinator.start()
        window = authWindow
    }
    
    private func openMainScene() {
        let mainWindow = UIWindow(windowScene: windowScene)
        let nc = UINavigationController()
        mainWindow.rootViewController = nc
        mainWindow.makeKeyAndVisible()
        
        let tabBarCoordinator = TabBarCoordinator(
            rootNavigationController: nc,
            rootCoordinator: self,
            container: container
        )
        childCoordinators.append(tabBarCoordinator)
        tabBarCoordinator.start()
        window = mainWindow
    }
    
    private func makeParametersService() -> ParametersServiceProtocol {
        return container.resolve()
    }
    
}

extension AppCoordinator: TabBarRootCoordinatorProtocol {
    func finished(_ coordinator: Coordinator) {
        childCoordinators.removeAll { tmp in
            tmp === coordinator
        }
        start()
    }
}

extension AppCoordinator: AuthRootCoordinatorProtocol {
    func authFinished(_ coordinator: Coordinator) {
        childCoordinators.removeAll { tmp in
            tmp === coordinator
        }
        start()
    }
}
