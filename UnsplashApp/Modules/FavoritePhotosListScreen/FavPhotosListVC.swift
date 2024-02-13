import UIKit

final class FavPhotosListVC: UIViewController {
    
    private var tableView: UITableView = UITableView(frame: .zero)
 
    private var viewModel: FavPhotosListVMProtocol
    
    init(viewModel: FavPhotosListVMProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        requiredInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func requiredInit() {
        tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "heart"), tag: 1)
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
        configureTableView()
        setupViewConstraints()
    }
    
    private func configureTableView() {
        configureTableViewStyle()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }
    
    private func setupViewConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func configureTableViewStyle() {
        tableView.layer.cornerRadius = 10
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = true
        tableView.isScrollEnabled = true
        tableView.selectRow(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .none)
        tableView.register(FavPhotoCell.self, forCellReuseIdentifier: "\(FavPhotoCell.self)")
    }
    
}

extension FavPhotosListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 14
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(FavPhotoCell.self)", for: indexPath) as? FavPhotoCell else { return UITableViewCell() }
        cell.configureCell(authorName: "Author", image: UIImage(systemName: "heart")!)
        return cell
    }
}
