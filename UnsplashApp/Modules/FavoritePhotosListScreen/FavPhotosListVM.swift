import Foundation

final class FavPhotosListVM: FavPhotosListVMProtocol {
    private weak var coordinator: FavPhotosListCoordinatorProtocol?
    
    init(
        coordinator: FavPhotosListCoordinatorProtocol
    ) {
        self.coordinator = coordinator
    }
    
    func showPhotoInfoVC() {
        coordinator?.showPhotoInfoVC()
    }
    
    func finish() {
        coordinator?.finish()
    }
}
