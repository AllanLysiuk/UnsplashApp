import Foundation

final class FavPhotosListVM: FavPhotosListVMProtocol {
    private weak var coordinator: FavPhotosListCoordinatorProtocol?
    
    init(
        coordinator: FavPhotosListCoordinatorProtocol
    ) {
        self.coordinator = coordinator
    }
    
    func finish() {
        coordinator?.finish()
    }
}
