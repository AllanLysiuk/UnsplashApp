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
        self.parametersService.saveUserAccessToken(accessToken)
        self.parametersService.userHasLoggedIn()
        self.finish()
//        authService.requestUserName(userToken: accessToken) { [weak self] result in
//            guard let self = self else { return }
//            switch result {
//            case .success(let success):
//                self.parametersService.saveUserName(success.username)
//                self.parametersService.saveUserAccessToken(accessToken)
//                self.parametersService.userHasLoggedIn()
//                self.finish()
//            case .failure(let failure):
//                print(failure.localizedDescription)
//            }
//        }
        
    }
    
    func showAlert(title: String?, message: String?, actions: [AlertControllerFactory.AlertAction]) {
        let alert = alertFactory.makeAlert(title: title, message: message, actions: actions)
        coordinator?.showAlert(alert)
    }
    
    func finish() {
        coordinator?.finish()
    }
}
