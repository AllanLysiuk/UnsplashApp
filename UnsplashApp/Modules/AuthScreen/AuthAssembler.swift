import UIKit

final class AuthAssembler {
    private init(){ }
       
       static func makeAuthVC(
        coordinator: AuthCoordinatorProtocol,
        container: Container
       ) -> UIViewController {
           let vc = AuthVC(
            viewModel: makeViewModel(
                coordinator: coordinator,
                container: container
            )
           )
           return vc
       }
       
       private static func makeViewModel(
        coordinator: AuthCoordinatorProtocol,
        container: Container
       ) -> AuthVM {
           return AuthVM(
            coordinator: coordinator,
            authService: makeAuthService(container: container)
           )
       }
    
    private static func makeAuthService(container: Container) -> AuthServiceProtocol {
        return container.resolve()
    }
}
