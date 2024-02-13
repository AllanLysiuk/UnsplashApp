import UIKit

final class PhotoCell: UICollectionViewCell {
    
    private var imageView: UIImageView = UIImageView(frame: .zero)
    private var loaderView: UIActivityIndicatorView = UIActivityIndicatorView(frame: .zero)
    
    var viewModel: ImageDownloadCellVMProtocol!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        startIndicatorAnimation()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        viewModel.prepareForReuse()
    }
    
    private func startIndicatorAnimation() {
        loaderView.startAnimating()
        loaderView.isHidden = false
    }
    
    private func stopIndicatorAnimation() {
        loaderView.stopAnimating()
    }
    
    private func configureUI() {
        configureImageView()
        configureLoaderView()
        
        setupViewConstraints()
    }
    
    private func configureImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        addSubview(imageView)
    }
    
    private func configureLoaderView() {
        loaderView.translatesAutoresizingMaskIntoConstraints = false
        loaderView.hidesWhenStopped = true
        addSubview(loaderView)
    }
    
    
    private func setupViewConstraints() {
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: -24),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            loaderView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            loaderView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
    
    func configureCell( imageURL: URL) {
        viewModel.loadImage(by: imageURL) { [weak self] in
            self?.stopIndicatorAnimation()
            self?.imageView.image = $0
        }
    }
}
