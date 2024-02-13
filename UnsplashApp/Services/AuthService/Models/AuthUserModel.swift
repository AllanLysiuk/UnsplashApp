import Foundation

struct AuthUserModel: Codable {
    let client_id: String
    let client_secret: String
    let redirect_uri: String
    let code: String
    let grant_type: String
}
