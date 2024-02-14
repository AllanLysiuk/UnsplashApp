import Foundation

final class ServiceConfigurations {
    
    private init() {  }
    
    static func configure(container: Container) {
        container.register({ Self.parametersService })
        container.register({ Self.authService })
        container.register({ Self.alertFactory })
        container.register({ Self.networkService })
        container.register({ Self.imageDownloadService })
    }
}

protocol ParametersServiceProtocol: AnyObject,
                                    AppCoordinatorParametersServiceProtocol,
                                    AuthVCParametersServiceProtocol {}

protocol AuthServiceProtocol: AnyObject,
                              AuthVCAuthServiceProtocol {}

protocol AlertFactoryProtocol: AnyObject,
                               AlertControllerFactoryProtocol {}

protocol NetworkServiceProtocol: AnyObject,
                                 PhotoListNetworkServiceProtocol {}


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
    
    static var networkService: NetworkServiceProtocol {
        return NetworkService()
    }

    static var imageDownloadService: ImageDownloadServiceProtocol {
        return ImageDownloadService(cache: .shared)
    }
}
