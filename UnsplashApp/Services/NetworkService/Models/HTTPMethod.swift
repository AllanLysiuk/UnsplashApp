import Foundation

enum HTTPMethod: String {
    static let scheme = "https"
    
    static let jsonHeaderValue = "application/json"
    static let jsonHeaderField = "Content-Type"
    
    case get = "GET"
    case post = "POST"
}
