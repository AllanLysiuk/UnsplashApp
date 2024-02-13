import Foundation

final class PhotoInfoVM: PhotoInfoVMProtocol {
    private weak var coordinator: PhotoInfoCoordinatorProtocol?
    
    init(
        coordinator: PhotoInfoCoordinatorProtocol
    ) {
        self.coordinator = coordinator
    }
    
    func finish(shouldMoveToParent: Bool) {
        coordinator?.finish(shouldMoveToParent: shouldMoveToParent)
    }
}

