import Foundation

protocol PhotoListCoordinatorProtocol: AnyObject {
    func showPhotoInfoVC(for photo: Photo)
    func finish()
}
