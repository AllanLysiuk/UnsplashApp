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
        viewModel.getPhotosList { error in
            if error.isNil {
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                
            }
        }
        
//        NetworkService().getPhotosList { result in
//            
//        }
        
//        NetworkService().likeAPhoto(userToken: ParametersService().requestUserAccessToken()!, id: "2C7eeUriLy0") { error in
//            
//        }
//        
//        
//        NetworkService().getUsersLikedPhotosID(userToken: ParametersService().requestUserAccessToken()!, userName: ParametersService().getUserName()!) { error in
//            
//        }
//
//        NetworkService().unlikeAPhoto(userToken: ParametersService().requestUserAccessToken()!, id: "2C7eeUriLy0") { error in
//            
//        }
        
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
        return viewModel.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(PhotoCell.self)", for: indexPath) as? PhotoCell else { return UICollectionViewCell() }
        cell.viewModel = ImageDownloadCellAssembler.makeVM()
        cell.configureCell(imageURL: viewModel.photos[indexPath.row].urls.url)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.showPhotoInfoVC(for: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let lastIndex = viewModel.photos.count - 1
        if indexPath.row == lastIndex {
            viewModel.getPhotosList { error in
                if error.isNil {
                    DispatchQueue.main.async {
                        collectionView.reloadData()
                    }
                }
            }
        }
    }
    
}

extension PhotoListVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }

}
