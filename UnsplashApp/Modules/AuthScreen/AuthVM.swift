import Foundation

final class AuthVM: AuthVMProtocol {
    private weak var coordinator: AuthCoordinatorProtocol?
    private var authService: AuthVCAuthServiceProtocol
    private var parametersService: AuthVCParametersServiceProtocol
    private var alertFactory: AlertControllerFactoryProtocol
    
    init(
        coordinator: AuthCoordinatorProtocol,
        authService: AuthVCAuthServiceProtocol,
        parametersService: AuthVCParametersServiceProtocol,
        alertFactory: AlertControllerFactoryProtocol
    ) {
        self.coordinator = coordinator
        self.authService = authService
        self.parametersService = parametersService
        self.alertFactory = alertFactory
    }
    
    func configureAuthUrl(completion: @escaping (Result<URLRequest, AuthError>) -> Void) {
        authService.configureAuthUrl(completion: completion)
    }
    
    func requestUserAccessToken(url: URL, completion: @escaping (Result<String, AuthError>) -> Void) {
        authService.requestUserAccessToken(url: url, completion: completion)
    }
    
    func userLoggedIn(with accessToken: String) {
        parametersService.saveUserAccessToken(accessToken)
        parametersService.userHasLoggedIn()
        finish()
    }
    
    func showAlert(title: String?, message: String?, actions: [AlertControllerFactory.AlertAction]) {
        let alert = alertFactory.makeAlert(title: title, message: message, actions: actions)
        coordinator?.showAlert(alert)
    }
    
    func finish() {
        coordinator?.finish()
    }
}
