import Foundation

enum HTTPMethod: String {
    static let scheme = "https"
    
    static let jsonHeaderValue = "application/json"
    static let jsonHeaderField = "Content-Type"
    
    static let bearerTokenHeaderValue = "Bearer "
    static let bearerTokenHeaderField = "Authorization"
    
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
}
