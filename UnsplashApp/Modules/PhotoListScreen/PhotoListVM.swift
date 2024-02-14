import Foundation

final class PhotoListVM: PhotoListVMProtocol {
    private weak var coordinator: PhotoListCoordinatorProtocol?
    private var networkService: PhotoListNetworkServiceProtocol
    
    var photos: [Photo] = []
    
    init(
        coordinator: PhotoListCoordinatorProtocol,
        networkService: PhotoListNetworkServiceProtocol
    ) {
        self.coordinator = coordinator
        self.networkService = networkService
    }
    
    func getPhotosList(completion: @escaping (NetworkError?) -> Void) {
        networkService.getPhotosList() { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let success):
                self.photos.append(contentsOf: success)
                completion(nil)
            case .failure(let failure):
                print(failure.localizedDescription)
                completion(failure)
            }
        }
    }
    
    func showPhotoInfoVC(for photoIndex: Int) {
        coordinator?.showPhotoInfoVC(for: photos[photoIndex])
    }
    
    func finish() {
        coordinator?.finish()
    }
}
