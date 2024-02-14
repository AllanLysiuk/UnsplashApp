import Foundation

struct AuthUserModel: Codable {
    let clientID: String
    let clientSecret: String
    let redirectUri: String
    let code: String
    let grantType: String
    
    enum CodingKeys: String, CodingKey {
        case clientID = "client_id"
        case clientSecret = "client_secret"
        case redirectUri = "redirect_uri"
        case code
        case grantType = "grant_type"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.clientID, forKey: .clientID)
        try container.encode(self.clientSecret, forKey: .clientSecret)
        try container.encode(self.redirectUri, forKey: .redirectUri)
        try container.encode(self.code, forKey: .code)
        try container.encode(self.grantType, forKey: .grantType)
    }
}
