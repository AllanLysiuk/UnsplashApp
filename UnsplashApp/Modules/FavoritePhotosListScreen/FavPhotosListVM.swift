import Foundation

final class FavPhotosListVM: FavPhotosListVMProtocol {
    private weak var coordinator: FavPhotosListCoordinatorProtocol?
    private var networkService: FavPhotoListNetworkServiceProtocol
    
    var photos: [Photo] = []
    
    init(
        coordinator: FavPhotosListCoordinatorProtocol,
        networkService: FavPhotoListNetworkServiceProtocol
    ) {
        self.coordinator = coordinator
        self.networkService = networkService
    }
    
    func showPhotoInfoVC(for index: Int) {
        coordinator?.showPhotoInfoVC(for: photos[index])
    }
    
    func finish() {
        coordinator?.finish()
    }
}
