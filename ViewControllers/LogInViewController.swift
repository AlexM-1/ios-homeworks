

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
        $0.backgroundColor = .systemBackground
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
        $0.textColor = .label
        $0.font = .systemFont(ofSize: 16, weight: .regular)
        $0.placeholder = "Email or phone".localizable
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
        $0.placeholder = "Password".localizable
        $0.delegate = self
        $0.contentVerticalAlignment = .center
        $0.textColor = .label
        $0.font = .systemFont(ofSize: 16, weight: .regular)
        $0.backgroundColor = .systemGray6
        $0.isSecureTextEntry = true
        let spacerView = UIView(frame:CGRect(x:0, y:0, width:10, height:10))
        $0.leftViewMode = UITextField.ViewMode.always
        $0.leftView = spacerView
        return $0
    }(UITextField())
    

    private lazy var logInButton = CustomButton(title: "Log In".localizable + " 0 " + "seconds".localizable, titleColor: .white) {}

    private lazy var signUpButton = CustomButton(title: "sign Up".localizable, titleColor: .white) {}


    private lazy var authenticationWithBiometricsButton = CustomButton(title: "Biometrics".localizable, titleColor: .white) {
        self.viewModel.changeState(.biometricsButtonTap)
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
        view.backgroundColor = .systemBackground
        self.navigationController?.isNavigationBarHidden = true
        setupView()
        layout()
        bindViewModel()
        viewModel.startTimer()
        setupButtons()
        viewModel.changeState(.chekForAutorized)
    }
    
    func setupButtons () {
        logInButton.addTarget(self, action: #selector(logInButtonTap), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(signUpButtonTap), for: .touchUpInside)
        

        switch viewModel.biometricType {
        case .none, .unknown:
            authenticationWithBiometricsButton.isHidden = true
        case .touch:
            authenticationWithBiometricsButton.setImage(UIImage(systemName: "touchid"), for: .normal)
            authenticationWithBiometricsButton.setTitle("Войти по Touch ID", for: .normal)
        case .face:
            authenticationWithBiometricsButton.setImage(UIImage(systemName: "faceid"), for: .normal)
            authenticationWithBiometricsButton.setTitle("Войти по Face ID", for: .normal)
        }


    }

    func bindViewModel() {
        viewModel.logInButtonText.bind({ text in
            DispatchQueue.main.async {
                self.logInButton.setTitle(text, for: .normal)
            }
        })
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
        [logoImageView, stackView, logInButton, signUpButton, authenticationWithBiometricsButton].forEach { contentView.addSubview($0) }
        
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

            signUpButton.topAnchor.constraint(equalTo: logInButton.bottomAnchor, constant: 16),
            signUpButton.leadingAnchor.constraint(equalTo: logInButton.leadingAnchor),
            signUpButton.trailingAnchor.constraint(equalTo: logInButton.trailingAnchor),
            signUpButton.heightAnchor.constraint(equalToConstant: 50),

            authenticationWithBiometricsButton.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 16),
            authenticationWithBiometricsButton.leadingAnchor.constraint(equalTo: signUpButton.leadingAnchor),
            authenticationWithBiometricsButton.trailingAnchor.constraint(equalTo: signUpButton.trailingAnchor),
            authenticationWithBiometricsButton.heightAnchor.constraint(equalToConstant: 50),

            authenticationWithBiometricsButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)







        ])
        
    }
    
    @objc func logInButtonTap() {
        viewModel.login = loginTextField.text!
        viewModel.pswd = passwordTextField.text!
        viewModel.changeState(.logInButtonTap)

    }

    @objc func signUpButtonTap() {
        viewModel.login = loginTextField.text!
        viewModel.pswd = passwordTextField.text!
        viewModel.changeState(.signUpButtonTap)
    }
    
}

extension LogInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}




