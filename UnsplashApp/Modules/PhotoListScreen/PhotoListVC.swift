import UIKit

final class PhotoListVC: UIViewController {
    
    private var searchBar: UISearchBar = UISearchBar(frame: .zero)
    private var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    
    private var viewModel: PhotoListVMProtocol
    
    init(viewModel: PhotoListVMProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        requiredInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func requiredInit() {
        tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "circle.grid.3x3"), tag: 0)
        navigationController?.tabBarItem = tabBarItem
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        configureCollectionView()
        configureSearchBar()
        
        setupViewConstraints()
    }
    
    private func configureCollectionView() {
        createCollectionViewLayout()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
    }
    
    private func configureSearchBar() {
        searchBar.delegate = self
        searchBar.backgroundColor = .black
        searchBar.returnKeyType = .search
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchBar)
    }
    
    private func setupViewConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func createCollectionViewLayout() {
        guard let screenWidth = UIScreen.current?.bounds.width else { return }
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: screenWidth/2, height: screenWidth/2)
        
        collectionView.collectionViewLayout = layout
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: "\(PhotoCell.self)")
    }
    
}

extension PhotoListVC: UICollectionViewDelegate,
                       UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(PhotoCell.self)", for: indexPath) as? PhotoCell else { return UICollectionViewCell() }
        cell.viewModel = ImageDownloadCellAssembler.makeVM()
        if let url = URL(string: "https://images.unsplash.com/photo-1417325384643-aac51acc9e5d?q=75&fm=jpg&w=1080&fit=max") {
            cell.configureCell(imageURL: url)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.showPhotoInfoVC()
    }
    
}

extension PhotoListVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        
    }

}
