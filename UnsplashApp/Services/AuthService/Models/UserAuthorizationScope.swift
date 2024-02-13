import Foundation

enum UserAuthorizationScope: String {
    case `public`
    
    case readUser = "read_user"
    case writeUser = "write_user"
    
    case readPhotos = "read_photos"
    case writePhotos = "write_photos"
    
    case writeLikes = "write_likes"
    
    case readCollections = "read_collections"
    case writeCollections = "write_collections"
    
    static let scopeSeparator = "+"
}
