import Foundation

protocol AuthVCParametersServiceProtocol {
    func userHasLoggedIn()
    func saveUserAccessToken(_ accessToken: String)
}
