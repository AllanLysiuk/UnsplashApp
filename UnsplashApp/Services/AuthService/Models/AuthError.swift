import Foundation

enum AuthError: Error {
    case incorrectAuthURL
    case incorrectAuthURLComponents
    case incorrectTokenURLComponents
    case jsonTokenResponseIncorrectKey
    case incorrectUsernameUrlComponents
    case serverError(error: Error)
    case clientError
    
    //TODO: remove string add errors description
    var errorTitle: String {
        switch self {
        case .serverError(let error):
            return "Oops smth went wrong"
        default :
            return ""
        }
    }
}
