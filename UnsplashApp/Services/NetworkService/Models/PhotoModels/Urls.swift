import Foundation

struct Urls: Codable {
    let regular: String
    
    var url: URL {
        return URL(string: regular)!
    }
}
