import Foundation

protocol PhotoListVMProtocol {
    func getPhotosList(completion: @escaping (NetworkError?) -> Void)
    func showPhotoInfoVC(for photoIndex: Int)
    func finish()
    
    var photos: [Photo] { get }
}
