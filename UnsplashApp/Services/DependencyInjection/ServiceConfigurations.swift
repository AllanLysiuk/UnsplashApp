import Foundation

final class ServiceConfigurations {
    
    private init() {  }
    
    static func configure(container: Container) {
        container.register({ Self.parametersService })
        container.register({ Self.authService })
        container.register({ Self.alertFactory })
    }
}

protocol ParametersServiceProtocol: AnyObject,
                                    AppCoordinatorParametersServiceProtocol,
                                    AuthVCParametersServiceProtocol {}

protocol AuthServiceProtocol: AnyObject,
                              AuthVCAuthServiceProtocol {}

protocol AlertFactoryProtocol: AnyObject, AlertControllerFactoryProtocol {}

private extension ServiceConfigurations {
    
    static var parametersService: ParametersServiceProtocol {
        return ParametersService()
    }
    
    static var authService: AuthServiceProtocol {
        return AuthService()
    }
    
    static var alertFactory: AlertFactoryProtocol {
        return AlertControllerFactory()
    }

}
