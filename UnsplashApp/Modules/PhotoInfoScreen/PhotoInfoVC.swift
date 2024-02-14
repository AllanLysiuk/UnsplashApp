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
        setUpActions()
        downloadSelectedPhoto()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if parent == nil {
            viewModel.finish(shouldMoveToParent: false)
        }
    }
    
    private func setUpActions() {
        likeButton.addTarget(self,
                             action: #selector(likeButtonDidTap),
                             for: .touchUpInside)
    }
    
    //TODO: Liked photo is not passing like to previous screen
    @objc private func likeButtonDidTap() {
        likeButton.isSelected = !likeButton.isSelected
        if likeButton.isSelected {
            viewModel.likeAPhoto()
        } else {
            viewModel.unlikeAPhoto()
        }
    }
    
    private func downloadSelectedPhoto() {
        viewModel.downloadImage { result in
            switch result {
            case .success(let success):
                self.imageView.image = success
            case .failure(let failure):
                print(failure.localizedDescription)
            }
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
        view.addSubview(imageView)
    }
    
    private func configureAuthorNameLabel() {
        authorNameLabel.translatesAutoresizingMaskIntoConstraints = false
        authorNameLabel.textColor = .black
        authorNameLabel.text = ConstStrings.PhotoInfo.authorLabel + (viewModel.photo.user.name ?? ConstStrings.PhotoInfo.noInfo)
        authorNameLabel.font = .boldSystemFont(ofSize: 20)
        view.addSubview(authorNameLabel)
    }
    
    private func configureCreationDateLabel() {
        creationDateLabel.translatesAutoresizingMaskIntoConstraints = false
        creationDateLabel.textColor = .black
        creationDateLabel.text = ConstStrings.PhotoInfo.creationDateLabel + Date().convertFromISO8601String(viewModel.photo.createdAt)
        creationDateLabel.font = .boldSystemFont(ofSize: 20)
        view.addSubview(creationDateLabel)
    }
    
    private func configureLocationLabel() {
        locationLabel.textColor = .black
        locationLabel.text = ConstStrings.PhotoInfo.locationLabel + (viewModel.photo.location.name ?? ConstStrings.PhotoInfo.noInfo)
        locationLabel.font = .boldSystemFont(ofSize: 20)
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(locationLabel)
    }
    
    private func configureDownloadsAmountLabel() {
        downloadsAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        downloadsAmountLabel.textColor = .black
        downloadsAmountLabel.text = ConstStrings.PhotoInfo.downloadsLabel + "\(viewModel.photo.downloads)"
        downloadsAmountLabel.font = .boldSystemFont(ofSize: 20)
        view.addSubview(downloadsAmountLabel)
    }
    
    private func configureLikeButton() {
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        likeButton.backgroundColor = .clear
        likeButton.isSelected = viewModel.photo.likedByUser
        likeButton.setImage(ImageAssets.unlikedPhoto, for: .normal)
        likeButton.imageView?.tintColor = .red
        likeButton.setImage(ImageAssets.likedPhoto, for: .selected)
        view.addSubview(likeButton)
    }
    
    private func setupViewConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 400)
        ])
        
        NSLayoutConstraint.activate([
            authorNameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            authorNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            authorNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            creationDateLabel.topAnchor.constraint(equalTo: authorNameLabel.bottomAnchor, constant: 8),
            creationDateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            creationDateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            locationLabel.topAnchor.constraint(equalTo: creationDateLabel.bottomAnchor, constant: 8),
            locationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            downloadsAmountLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 8),
            downloadsAmountLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            downloadsAmountLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            likeButton.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            likeButton.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -8),
            likeButton.heightAnchor.constraint(equalToConstant: 50),
            likeButton.widthAnchor.constraint(equalToConstant: 50),
        ])
    }
    
}
