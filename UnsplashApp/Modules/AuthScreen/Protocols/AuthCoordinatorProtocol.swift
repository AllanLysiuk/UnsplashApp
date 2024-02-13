import UIKit

protocol AuthCoordinatorProtocol: AnyObject {
    func showAlert(_ alert: UIAlertController)
    func finish()
}
