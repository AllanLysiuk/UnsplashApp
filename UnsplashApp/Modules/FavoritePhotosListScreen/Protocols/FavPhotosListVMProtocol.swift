import Foundation

protocol FavPhotosListVMProtocol {
    func showPhotoInfoVC(for index: Int)
    func finish()
    
    var photos: [Photo] { get }
}
