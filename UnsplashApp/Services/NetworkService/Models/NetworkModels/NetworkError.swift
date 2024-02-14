import Foundation

enum NetworkError: Error {
    case serverError(Error?)
    case clientError
    case urlComponentsError
}
