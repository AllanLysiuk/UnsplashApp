import Foundation

final class AuthVM: AuthVMProtocol {
    private weak var coordinator: AuthCoordinatorProtocol?
    private var authService: AuthVCAuthServiceProtocol
    
    init(
        coordinator: AuthCoordinatorProtocol,
        authService: AuthVCAuthServiceProtocol
    ) {
        self.coordinator = coordinator
        self.authService = authService
    }
    
    func finish() {
        coordinator?.finish()
    }
}
