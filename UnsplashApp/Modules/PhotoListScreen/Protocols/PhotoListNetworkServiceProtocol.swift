import Foundation

protocol PhotoListNetworkServiceProtocol {
    func getPhotosList(completion: @escaping (Result<[Photo], NetworkError>) -> Void)
}
