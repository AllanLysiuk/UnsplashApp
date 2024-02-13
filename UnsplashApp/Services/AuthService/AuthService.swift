import Foundation

final class AuthService: AuthServiceProtocol {
    private enum AuthKeys {
        static let logInPath = "unsplash.com/oauth/authorize"
        static let redirectAuthenticationURI = "https://unsplash.com/oauth/authorize/native"
        static let tokenPath = "unsplash.com/oauth/token"
        static let responseType = "code"
    }
    
    func configureAuthUrl(completion: @escaping (Result<URLRequest, AuthError>) -> Void) {
        let scope: Set<UserAuthorizationScope> = [.public]
        let formattedScope = scope
            .map { $0.rawValue }
            .joined(separator: UserAuthorizationScope.scopeSeparator)
        
        var queryItems = [
            URLQueryItem(
                name: AuthQueryParameterName.accessKey,
                value: UNCredentials.accessKey
            ),
            URLQueryItem(
                name: AuthQueryParameterName.redirectUrl,
                value: UNCredentials.redirectURI
            ),
            URLQueryItem(
                name: AuthQueryParameterName.responseType,
                value: AuthKeys.responseType
            )]
        queryItems.append(
            URLQueryItem(
            name: AuthQueryParameterName.scope,
            value: formattedScope
            )
        )
        
        var urlComponents = URLComponents()
        urlComponents.queryItems = queryItems
        urlComponents.path = AuthKeys.logInPath
        urlComponents.scheme = HTTPMethod.scheme
        
        guard let authUrl = urlComponents.url else {
            //TODO: Change Error
            completion(.failure(.incorrectAuthorizationURL))
            return
        }
        completion(.success(URLRequest(url: authUrl)))
    }
    
    func getUserAccessToken(url: URL, completion: @escaping (Result<String, AuthError>) -> Void) {
        let components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        let baseURL = url.absoluteString.components(separatedBy: "?").first
        guard baseURL == AuthKeys.redirectAuthenticationURI,
              let codeItem = components?.queryItems?.first(where: { $0.name == AuthKeys.responseType }),
              let code = codeItem.value else {
            completion(.failure(.incorrectAuthorizationURL))
            return
        }
        
        var tokenUrlComponents = URLComponents()
        tokenUrlComponents.path = AuthKeys.tokenPath
        tokenUrlComponents.scheme = HTTPMethod.scheme
        guard let url = tokenUrlComponents.url else {
            //TODO: change error
            completion(.failure(.incorrectAuthorizationURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        
        let user = AuthUserModel(
            client_id: UNCredentials.accessKey,
            client_secret: UNCredentials.secretKey,
            redirect_uri: UNCredentials.redirectURI,
            code: code,
            grant_type: "authorization_code"
        )
        
        let data = try! JSONEncoder().encode(user)
        request.httpBody = data
        request.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
            }else if let response = response as? HTTPURLResponse, let data = data {
                print("Status Code: \(response.statusCode)")
                guard let JSON = try? JSONSerialization.jsonObject(
                    with: data,
                    options: .mutableContainers) as? [String: Any],
                      let accessToken = JSON["access_token"] as? String
                else {
                    //TODO: change error
                    completion(.failure(.incorrectAuthorizationURL))
                    return
                }
                completion(.success(accessToken))
            }
        }.resume()
    }
}


