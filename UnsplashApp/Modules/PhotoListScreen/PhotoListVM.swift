import Foundation

final class PhotoListVM: PhotoListVMProtocol {
    private weak var coordinator: PhotoListCoordinatorProtocol?
    
    init(
        coordinator: PhotoListCoordinatorProtocol
    ) {
        self.coordinator = coordinator
    }
    
    func finish() {
        coordinator?.finish()
    }
}
