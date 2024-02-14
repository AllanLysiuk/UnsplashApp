import Foundation

struct Photo: Codable {
    let urls: Urls
    let id: String
    let createdAt: String
    let downloads: Int
    let user: Author
    let location: ImageLocation
    
    enum CodingKeys: String, CodingKey {
        case urls
        case id
        case createdAt = "created_at"
        case downloads
        case user
        case location
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.urls = try container.decode(Urls.self, forKey: .urls)
        self.id = try container.decode(String.self, forKey: .id)
        self.createdAt = try container.decode(String.self, forKey: .createdAt)
        self.downloads = try container.decode(Int.self, forKey: .downloads)
        self.user = try container.decode(Author.self, forKey: .user)
        self.location = try container.decode(ImageLocation.self, forKey: .location)
    }
}
