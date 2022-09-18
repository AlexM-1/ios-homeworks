

import UIKit

class LogInViewController: UIViewController {

    private let viewModel: LogInViewModel

    private let nc = NotificationCenter.default


    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .white
        return $0
    }(UIView())
    
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "logo"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        stackView.layer.borderWidth = 0.5
        stackView.layer.cornerRadius = 10
        stackView.layer.masksToBounds = true
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    
    private lazy var loginTextField: UITextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.delegate = self
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 16, weight: .regular)
        $0.placeholder = "Email or phone"
        $0.keyboardType = .emailAddress
        $0.autocapitalizationType = .none
        $0.backgroundColor = .systemGray6
        $0.layer.borderWidth = 0.5
        $0.layer.borderColor = UIColor.lightGray.cgColor
        let spacerView = UIView(frame:CGRect(x:0, y:0, width:10, height:10))
        $0.leftViewMode = UITextField.ViewMode.always
        $0.leftView = spacerView
        return $0
    }(UITextField())
    
    private lazy var passwordTextField: UITextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.placeholder = "Password"
        $0.delegate = self
        $0.contentVerticalAlignment = .center
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 16, weight: .regular)
        $0.backgroundColor = .systemGray6
        $0.isSecureTextEntry = true
        let spacerView = UIView(frame:CGRect(x:0, y:0, width:10, height:10))
        $0.leftViewMode = UITextField.ViewMode.always
        $0.leftView = spacerView
        return $0
    }(UITextField())


    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    


    private lazy var logInButton = CustomButton(title: "Log In", titleColor: .white) {
        [weak self] in

        self?.viewModel.login = self?.loginTextField.text! ?? ""
        self?.viewModel.pswd = self?.passwordTextField.text! ?? ""
        self?.viewModel.changeState(.logInButtonTap)
    }


    private lazy var bruteForceButton = CustomButton(title: "Подобрать пароль", titleColor: .white) {
        [weak self] in

        self?.activityIndicator.startAnimating()

        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            self?.viewModel.changeState(.bruteForceButtonTap)

            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                self?.passwordTextField.text = self?.viewModel.pswd
                self?.passwordTextField.isSecureTextEntry = false

            }
        }
    }


    init(viewModel: LogInViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationController?.isNavigationBarHidden = true
        setupView()
        layout()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nc.addObserver(self, selector: #selector(kbdShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        nc.addObserver(self, selector: #selector(kbdHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        nc.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        nc.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    @objc private func kbdShow(notification: NSNotification) {
        if let kbdSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            scrollView.contentInset.bottom = kbdSize.height + 50
            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: kbdSize.height, right: 0)
        }
        
    }
    
    @objc private func kbdHide() {
        scrollView.contentInset = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
    }
    
    
    private func setupView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        stackView.addArrangedSubview(loginTextField)
        stackView.addArrangedSubview(passwordTextField)
        
        [loginTextField, passwordTextField].forEach { stackView.addArrangedSubview($0) }
        [logoImageView, stackView, logInButton, bruteForceButton, activityIndicator].forEach { contentView.addSubview($0) }
    }
    
    private func layout() {
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            logoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),
            logoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            logoImageView.widthAnchor.constraint(equalToConstant: 100),
            
            stackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 120),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.heightAnchor.constraint(equalToConstant: 100),
            
            logInButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
            logInButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            logInButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            logInButton.heightAnchor.constraint(equalToConstant: 50),



            activityIndicator.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: stackView.centerYAnchor),


            bruteForceButton.topAnchor.constraint(equalTo: logInButton.bottomAnchor, constant: 16),
            bruteForceButton.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),
            bruteForceButton.heightAnchor.constraint(equalToConstant: 50),
            bruteForceButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)

        ])
        
    }

}

extension LogInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}




