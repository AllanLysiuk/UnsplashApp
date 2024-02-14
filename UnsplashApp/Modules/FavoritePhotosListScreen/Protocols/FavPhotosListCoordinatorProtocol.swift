import Foundation

protocol FavPhotosListCoordinatorProtocol: AnyObject {
    func showPhotoInfoVC(for photo: Photo)
    func finish()
}
