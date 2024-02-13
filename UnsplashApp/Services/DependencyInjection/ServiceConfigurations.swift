import Foundation

final class ServiceConfigurations {
    
    private init() {  }
    
    static func configure(container: Container) {
        container.register({ Self.parametersService })
        container.register({ Self.authService })
    }
    
}

protocol ParametersServiceProtocol: AnyObject, AppCoordinatorParametersServiceProtocol {}

protocol AuthServiceProtocol: AnyObject, AuthVCAuthServiceProtocol {}
private extension ServiceConfigurations {
    
    static var parametersService: ParametersServiceProtocol {
        return ParametersService()
    }
    
    static var authService: AuthServiceProtocol {
        return AuthService()
    }

}
