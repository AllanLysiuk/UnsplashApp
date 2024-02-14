import Foundation

protocol AuthVCAuthServiceProtocol {
    func configureAuthUrl(completion: @escaping (Result<URLRequest, AuthError>) -> Void)
    func requestUserAccessToken(url: URL, completion: @escaping (Result<String, AuthError>) -> Void)
    func requestUserName(userToken: String, completion: @escaping (Result<UserName, AuthError>) -> Void)
}
