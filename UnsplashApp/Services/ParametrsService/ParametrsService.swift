import Foundation

final class ParametersService: ParametersServiceProtocol {
    
    private enum UDKeys {
        static let isUserLoggedIn = "isUserLoggedIn"
        static let userAccessToken = "userAccessToken"
    }
    
    private lazy var ud: UserDefaults = {
        return UserDefaults()
    }()
    
    func isUserLoggedIn() -> Bool {
        return ud.bool(forKey: UDKeys.isUserLoggedIn)
    }
    
    func userHasLoggedIn() {
        ud.setValue(true, forKey: UDKeys.isUserLoggedIn)
    }
    
}
