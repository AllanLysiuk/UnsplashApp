import Foundation

struct UserName: Codable {
    let username: String
    
    enum CodingKeys: String, CodingKey {
        case username = "username"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.username = try container.decode(String.self, forKey: .username)
    }
}
