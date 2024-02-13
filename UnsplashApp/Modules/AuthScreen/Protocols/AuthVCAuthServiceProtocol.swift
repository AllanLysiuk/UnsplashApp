import Foundation

protocol AuthVCAuthServiceProtocol {
    func configureAuthUrl(completion: @escaping (Result<URLRequest, AuthError>) -> Void)
    func getUserAccessToken(url: URL, completion: @escaping (Result<String, AuthError>) -> Void)
}
