import Foundation

final class NetworkService {
    
    private enum NetworkKeys {
        static let baseUrlPath = "api.unsplash.com"
        static let photosUrlPath = "photos"
        static let randomPhotoPath = "random"
        static let likePhotoPath = "like"
        static let userPhotoPath = "users"
        static let userLikedPhotoPath = "likes"
    }
        private var likedPhotosCurrentPage = 1
        private let itemsPerPage = 10
    
    func getPhotosList(completion: @escaping (Result<[Photo], NetworkError>) -> Void) {
        let queryItems = [
            URLQueryItem(
                name: QueryParameterName.accessKey,
                value: UNCredentials.accessKey
            ),
            URLQueryItem(
                name: QueryParameterName.numbOfPhotos,
                value: UNCredentials.numberOfPhotosPerRequset
            )]
        var urlComponents = URLComponents()
        urlComponents.path = generateUrlPath(pathComponents:
                                                [NetworkKeys.baseUrlPath,
                                                 NetworkKeys.photosUrlPath,
                                                 NetworkKeys.randomPhotoPath])
        urlComponents.queryItems = queryItems
        urlComponents.scheme = HTTPMethod.scheme
        
        guard let url = urlComponents.url else {
            completion(.failure(.urlComponentsError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(.serverError(error)))
            }else if let response = response as? HTTPURLResponse, let data = data {
                do{
                    let decoder = JSONDecoder()
                    let photoInfo = try decoder.decode([Photo].self, from: data)
                    completion(.success(photoInfo))
                }catch{
                    completion(.failure(.clientError))
                }
            }
        }.resume()
    }
    
    func requestUserLikedPhotos(completion: @escaping (Result<[Photo], NetworkError>) -> Void) {
        
    }
    
     func getUsersLikedPhotosID(userToken: String,userName: String, completion: @escaping (Result<[Photo], NetworkError>) -> Void) {
        let offset = likedPhotosCurrentPage * itemsPerPage
        
        let queryItems = [
            URLQueryItem(
                name: QueryParameterName.photosPage,
                value: "\(likedPhotosCurrentPage)"
            ),
            URLQueryItem(
                name: QueryParameterName.photosPerPage,
                value: "\(itemsPerPage)"
            )]
        var urlComponents = URLComponents()
        urlComponents.path = generateUrlPath(pathComponents:
                                                [NetworkKeys.baseUrlPath,
                                                 NetworkKeys.userPhotoPath,
                                                 userName,
                                                 NetworkKeys.userLikedPhotoPath])
        urlComponents.queryItems = queryItems
        urlComponents.scheme = HTTPMethod.scheme
        
        guard let url = urlComponents.url else {
            completion(.failure(.urlComponentsError))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
//        request.setValue(HTTPMethod.bearerTokenHeaderValue + userToken, forHTTPHeaderField: HTTPMethod.bearerTokenHeaderField)
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(.serverError(error)))
            }else if let response = response as? HTTPURLResponse, let data = data {
                do{
                    let decoder = JSONDecoder()
                    let photoInfo = try decoder.decode([Photo].self, from: data)
                    completion(.success(photoInfo))
                }catch{
                    completion(.failure(.clientError))
                }
            }
        }.resume()
    }
    
    func likeAPhoto(userToken: String, id: String, completion: @escaping (NetworkError?) -> Void) {
        likeUnlikePhoto(method: .post, userToken: userToken, id: id, completion: completion)
    }
    
    func unlikeAPhoto(userToken: String, id: String, completion: @escaping (NetworkError?) -> Void) {
        likeUnlikePhoto(method: .delete, userToken: userToken, id: id, completion: completion)
    }
    
    private func likeUnlikePhoto(method: HTTPMethod,
                                 userToken: String,
                                 id: String,
                                 completion: @escaping (NetworkError?) -> Void
    ) {
        var urlComponents = URLComponents()
        urlComponents.path = generateUrlPath(pathComponents:
                                                [NetworkKeys.baseUrlPath,
                                                 NetworkKeys.photosUrlPath,
                                                 id,
                                                 NetworkKeys.likePhotoPath])
        urlComponents.scheme = HTTPMethod.scheme
        guard let url = urlComponents.url else {
            completion(.urlComponentsError)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue(HTTPMethod.bearerTokenHeaderValue + userToken, forHTTPHeaderField: HTTPMethod.bearerTokenHeaderField)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
             if let response = response as? HTTPURLResponse, let _ = data {
                if ResponseStatusCode.isSuccess(code: response.statusCode) {
                    completion(nil)
                } else if ResponseStatusCode.isClientError(code: response.statusCode) {
                    completion(.clientError)
                } else {
                    completion(.serverError(error))
                }
            }
        }.resume()
    }
    
    private func generateUrlPath(pathComponents: [String]) -> String {
        var urlPath = ""
        for (index, component) in pathComponents.enumerated() {
            urlPath += component
            if index < pathComponents.count - 1 {
                urlPath += "/"
            }
        }
        return urlPath
    }
}
