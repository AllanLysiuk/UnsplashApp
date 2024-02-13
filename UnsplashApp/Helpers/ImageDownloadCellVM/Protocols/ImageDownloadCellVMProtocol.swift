import UIKit

protocol ImageDownloadCellVMProtocol {
    func prepareForReuse()
    func loadImage(by url: URL, completion: @escaping (UIImage?) -> Void)
}
