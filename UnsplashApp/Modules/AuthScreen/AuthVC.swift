import UIKit
import WebKit

final class AuthVC: UIViewController {
    
    private var webView: WKWebView = WKWebView(frame: .zero)
    
    private var viewModel: AuthVMProtocol
    
    init(viewModel: AuthVMProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        loadAuthUrl()
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
        configureWebView()
        setupViewConstraints()
    }
    
    private func configureWebView() {
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.navigationDelegate = self
    }
    
    private func setupViewConstraints() {
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func loadAuthUrl() {
        viewModel.configureAuthUrl { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let success):
                self.webView.load(success)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
}

extension AuthVC: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if let webViewUrl = webView.url {
            viewModel.requestUserAccessToken(url: webViewUrl) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let success):
                    self.viewModel.userLoggedIn(with: success)
                case .failure(let failure):
                    switch failure {
                    case .incorrectAuthURL,
                            .incorrectAuthURLComponents,
                            .incorrectTokenURLComponents,
                            .jsonTokenResponseIncorrectKey:
                        print(failure.localizedDescription)
                    case .serverError(error: let error):
                        self.viewModel.showAlert(title: failure.errorTitle, message: error.localizedDescription, actions: [.default(ConstStrings.DefaultAlert.okButtonTitle, nil)])
                    }
                }
            }
        }
    }
    
}
