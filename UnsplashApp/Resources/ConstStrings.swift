import Foundation

enum ConstStrings {
    
    enum Public {
        static let iso8601DateFormat = "yyyy-MM-ddTHH:mm:ssZ"
        static let defaultDateFormat = "yyyy-MM-dd"
    }
    
    enum PhotoInfo {
        static let authorLabel = "Author: "
        static let creationDateLabel = "Creation Date: "
        static let locationLabel = "Location: "
        static let downloadsLabel = "Downloads counter: "
        static let noInfo = "No info"
    }
    
    enum FavPhoto {
        static let unknownAuthor = "Unknown author"
    }
    
    enum DefaultAlert {
        static let okButtonTitle = "Ok"
        static let cancelButtonTitle = "Default"
        static let destructiveButtonTitle = "Destructive"
    }
}
