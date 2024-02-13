import UIKit

final class FavPhotoCell: UITableViewCell {
    
    private var image: UIImageView = UIImageView(frame: .zero)
    private var authorNameLabel: UILabel = UILabel(frame: .zero)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        self.backgroundColor = .red
        
        configureNameLabel()
        configureImageView()
        
        setupViewConstraints()
    }
    
    private func configureImageView() {
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        addSubview(image)
    }
    
    private func configureNameLabel() {
        authorNameLabel.translatesAutoresizingMaskIntoConstraints = false
        authorNameLabel.textColor = .white
        authorNameLabel.font = .boldSystemFont(ofSize: 14)
        authorNameLabel.textAlignment = .left
        addSubview(authorNameLabel)
    }
    
    private func setupViewConstraints() {
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            image.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            image.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            image.heightAnchor.constraint(equalToConstant: 60),
            image.widthAnchor.constraint(equalToConstant: 60)
        ])
        
        NSLayoutConstraint.activate([
            authorNameLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 16),
            authorNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            authorNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
    
    func configureCell(authorName: String, image: UIImage) {
        self.authorNameLabel.text = authorName
        self.image.image = image
    }
    
}
