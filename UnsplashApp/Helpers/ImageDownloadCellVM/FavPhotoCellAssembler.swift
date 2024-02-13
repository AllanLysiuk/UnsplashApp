import Foundation

final class ImageDownloadCellAssembler {
    
    private init() { }
    
    static func makeVM() -> ImageDownloadCellVMProtocol {
        return ImageDownloadCellVM(imageDownloadService: makeImageDownloadService())
    }
    
    private static func makeImageDownloadService() -> ImageDownloadServiceProtocol {
        return ImageDownloadService(cache: .shared)
    }
}
