import UIKit

protocol PhotoInfoVMProtocol {
    func downloadImage(completion: @escaping (Result<UIImage?, Error>) -> Void)
    func likeAPhoto()
    func unlikeAPhoto()
    func finish(shouldMoveToParent: Bool)
    
    var photo: Photo { get }
}
