import Foundation

protocol AuthVMProtocol {
    func configureAuthUrl(completion: @escaping (Result<URLRequest, AuthError>) -> Void)
    func requestUserAccessToken(url: URL, completion: @escaping (Result<String, AuthError>) -> Void)
    func userLoggedIn(with accessToken: String)
    func showAlert(title: String?, message: String?, actions: [AlertControllerFactory.AlertAction])
    func finish()
}
