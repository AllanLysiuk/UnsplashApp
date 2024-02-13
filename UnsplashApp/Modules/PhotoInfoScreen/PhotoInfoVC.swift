import UIKit

final class PhotoInfoVC: UIViewController {
    
    private var imageView: UIImageView = UIImageView(frame: .zero)
    private var authorNameLabel: UILabel = UILabel(frame: .zero)
    private var creationDateLabel: UILabel = UILabel(frame: .zero)
    private var locationLabel: UILabel = UILabel(frame: .zero)
    private var downloadsAmountLabel: UILabel = UILabel(frame: .zero)
    private var likeButton: UIButton = UIButton(frame: .zero)
    
    private var viewModel: PhotoInfoVMProtocol
    
    init(viewModel: PhotoInfoVMProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if parent == nil {
            viewModel.finish(shouldMoveToParent: false)
        }
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        configureImageView()
        configureAuthorNameLabel()
        configureLocationLabel()
        configureDownloadsAmountLabel()
        configureCreationDateLabel()
        configureLikeButton()
        
        setupViewConstraints()
    }
    
    private func configureImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "heart")
        view.addSubview(imageView)
    }
    
    private func configureAuthorNameLabel() {
        authorNameLabel.translatesAutoresizingMaskIntoConstraints = false
        authorNameLabel.textColor = .black
        authorNameLabel.text = "Author"
        authorNameLabel.font = .boldSystemFont(ofSize: 20)
        view.addSubview(authorNameLabel)
    }
    
    private func configureCreationDateLabel() {
        creationDateLabel.translatesAutoresizingMaskIntoConstraints = false
        creationDateLabel.textColor = .black
        creationDateLabel.text = "Author"
        creationDateLabel.font = .boldSystemFont(ofSize: 20)
        view.addSubview(creationDateLabel)
    }
    
    private func configureLocationLabel() {
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.textColor = .black
        locationLabel.text = "Author"
        locationLabel.font = .boldSystemFont(ofSize: 20)
        view.addSubview(locationLabel)
    }
    
    private func configureDownloadsAmountLabel() {
        downloadsAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        downloadsAmountLabel.textColor = .black
        downloadsAmountLabel.text = "Author"
        downloadsAmountLabel.font = .boldSystemFont(ofSize: 20)
        view.addSubview(downloadsAmountLabel)
    }
    
    private func configureLikeButton() {
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        likeButton.backgroundColor = .clear
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        likeButton.imageView?.tintColor = .red
        likeButton.setImage(UIImage(systemName: "heart"), for: .selected)
        view.addSubview(likeButton)
    }
    
    private func setupViewConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            authorNameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            authorNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            authorNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            creationDateLabel.topAnchor.constraint(equalTo: authorNameLabel.bottomAnchor, constant: 8),
            creationDateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            creationDateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            locationLabel.topAnchor.constraint(equalTo: creationDateLabel.bottomAnchor, constant: 8),
            locationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            downloadsAmountLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 8),
            downloadsAmountLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            downloadsAmountLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            likeButton.topAnchor.constraint(equalTo: downloadsAmountLabel.bottomAnchor, constant: 8),
            likeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            likeButton.heightAnchor.constraint(equalToConstant: 60),
            likeButton.widthAnchor.constraint(equalToConstant: 60),
        ])
    }
    
}
