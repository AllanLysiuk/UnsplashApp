import Foundation

protocol PhotoInfoNetworkServiceProtocol {
    func likeAPhoto(userToken: String, id: String, completion: @escaping (NetworkError?) -> Void)
    func unlikeAPhoto(userToken: String, id: String, completion: @escaping (NetworkError?) -> Void)
}
