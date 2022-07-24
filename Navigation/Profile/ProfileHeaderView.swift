import UIKit

class ProfileHeaderView: UIView {
    
    private var statusText: String = "Waiting for something..."

    private var user = User()

    private let tapGestureRecognizer = UITapGestureRecognizer()

    private var leadingImageView = NSLayoutConstraint()
    private var topImageView = NSLayoutConstraint()
    private var widthImageView = NSLayoutConstraint()
    private var heightImageView = NSLayoutConstraint()


    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "foto"))
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 50
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        return imageView
    }()


    private lazy var transparentView: UIView = {
        let view = UIView()
        view.alpha = 0.0
        view.backgroundColor = .systemGray6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()


    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Hipster Cat"
        label.textColor = .black
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = statusText
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    
    private lazy var setStatusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Set status", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 4
        button.layer.shadowOffset = CGSize (width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(setStatusButtonTap), for: .touchUpInside)
        return button
    }()

    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.configuration = .gray()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.alpha = 0.0
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.addTarget(self, action: #selector(closeButtonTap), for: .touchUpInside)
        return button
    }()


    private lazy var statusTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.placeholder = "Set your status..."
        let spacerView = UIView(frame:CGRect(x:0, y:0, width:10, height:10))
        textField.leftViewMode = UITextField.ViewMode.always
        textField.leftView = spacerView
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.spellCheckingType = .no
        return textField
    }()
    
    
 init(frame: CGRect, user: User) {
        super.init(frame: frame)
        self.user = user
        setupView()
        setupGesture()
    }
    



    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupGesture() {
        tapGestureRecognizer.addTarget(self, action: #selector(handleTapGesture))
        imageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func setupView() {
        [imageView, nameLabel, statusLabel, statusTextField, setStatusButton, transparentView, closeButton].forEach { self.addSubview($0) }
        createViewConstraint()

        nameLabel.text  = user.name
        statusLabel.text = user.status ?? ""
        imageView.image = user.image
        
    }
    
    private func createViewConstraint() {

        leadingImageView = imageView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 16)
        topImageView = imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16)
        widthImageView = imageView.widthAnchor.constraint(equalToConstant: 100)
        heightImageView = imageView.heightAnchor.constraint(equalToConstant: 100)

        NSLayoutConstraint.activate([
            leadingImageView, topImageView, widthImageView, heightImageView,
            self.heightAnchor.constraint(equalToConstant: 226),

            nameLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 132),
            nameLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -16),
            nameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 27),

            statusLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor),
            statusLabel.rightAnchor.constraint(equalTo: nameLabel.rightAnchor),
            statusLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 84),

            setStatusButton.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 16),
            setStatusButton.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -16),
            setStatusButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 160),
            setStatusButton.heightAnchor.constraint(equalToConstant: 50),

            statusTextField.leftAnchor.constraint(equalTo: nameLabel.leftAnchor),
            statusTextField.rightAnchor.constraint(equalTo: nameLabel.rightAnchor),
            statusTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 110),
            statusTextField.heightAnchor.constraint(equalToConstant: 40),

            closeButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            closeButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            closeButton.widthAnchor.constraint(equalToConstant: 27),
            closeButton.heightAnchor.constraint(equalToConstant: 27),

            transparentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            transparentView.topAnchor.constraint(equalTo: self.topAnchor),
            transparentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            transparentView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height)
        ])

    }
    
    
    @objc func setStatusButtonTap() {
        statusTextChanged(statusTextField.text ?? "")
        statusLabel.text = statusText
        statusTextField.endEditing(true)
    }


    @objc func closeButtonTap() {
        UIView.animate(withDuration: 0.3, delay: 0) {
            self.closeButton.alpha = 0.0
            self.layoutIfNeeded()
        } completion: { _ in

            UIView.animate(withDuration: 0.5, delay: 0) {
                self.topImageView.constant =  16
                self.leadingImageView.constant = 16
                self.widthImageView.constant = 100
                self.heightImageView.constant = 100

                self.imageView.layer.cornerRadius = 50
                self.imageView.layer.borderWidth = 3
                self.transparentView.alpha = 0.0
                self.layoutIfNeeded()
            }
        }
    }

    
    func statusTextChanged(_ status: String) {
        statusText = status
        if statusText == "" {
            statusText = "Статус не установлен"
        }
    }


    @objc private func handleTapGesture(_ gestureRecognizer: UITapGestureRecognizer) {

        guard tapGestureRecognizer === gestureRecognizer else { return }

        UIView.animate(withDuration: 0.5, delay: 0) {
            self.topImageView.constant = (UIScreen.main.bounds.height - UIScreen.main.bounds.width) / 2
            self.leadingImageView.constant = 0
            self.widthImageView.constant = UIScreen.main.bounds.width
            self.heightImageView.constant = UIScreen.main.bounds.width

            self.imageView.layer.cornerRadius = 0
            self.imageView.layer.borderWidth = 0
            self.bringSubviewToFront(self.imageView)

            self.transparentView.alpha = 0.7
            self.layoutIfNeeded()
        }   completion: { _ in

            UIView.animate(withDuration: 0.3, delay: 0) {
                self.closeButton.alpha = 1.0
                self.layoutIfNeeded()
            }
        }
    }

}

