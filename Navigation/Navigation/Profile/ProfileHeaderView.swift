import UIKit

class ProfileHeaderView: UIView {

    private var statusText: String = "Waiting for something..."

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "foto"))
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 50
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        return imageView
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Hipster Cat"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()

    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Waiting for something..."
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14)
        label.isUserInteractionEnabled = true
        let guestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(labelClicked))
        label.addGestureRecognizer(guestureRecognizer)
        return label
    }()

    private lazy var statusButton: UIButton = {
        let button = UIButton()
        button.setTitle("Set status", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 4
        button.layer.shadowOffset = CGSize (width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(statusButtonTap), for: .touchUpInside)
        return button
    }()


    private lazy var statusTextField: UITextField = {
        let textField = UITextField()
        textField.text = statusText
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.addTarget(self, action: #selector(setStatus), for: .editingChanged)
        textField.isHidden = true
        textField.placeholder = "Status"
        let spacerView = UIView(frame:CGRect(x:0, y:0, width:10, height:10))
        textField.leftViewMode = UITextField.ViewMode.always
        textField.leftView = spacerView
        return textField
    }()



    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()


    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
        return stackView
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = CGRect(x: 16, y: 16, width: 100, height: 100)

        nameLabel.frame = CGRect(x: imageView.frame.maxX + 16,
                                 y: 27,
                                 width: self.bounds.width - (imageView.frame.maxX + 16) - 16,
                                 height: 32)

        statusLabel.frame = CGRect(x: nameLabel.frame.minX,
                                   y: imageView.frame.maxY - 18 - 14,
                                   width: self.bounds.width - (imageView.frame.maxX + 16) - 16,
                                   height: 18)

        statusTextField.frame = CGRect(x: nameLabel.frame.minX,
                                       y: statusLabel.frame.maxY,
                                       width: self.bounds.width - (imageView.frame.maxX + 16) - 16,
                                       height: 40)

        statusButton.frame = CGRect(x: 16, y: imageView.frame.maxY + 32, width: self.bounds.width - 32, height: 50)

    }

    private func setupView() {
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(statusButton)
        addSubview(statusLabel)
        addSubview(statusTextField)
    }

    @objc func statusButtonTap() {
        print(statusLabel.text ?? "nilStatus")
        statusLabel.text = statusText
        statusTextField.isHidden.toggle()
    }



    @objc func setStatus(_ textField: UITextField) {
        statusText = textField.text ?? ""
        if statusText == "" {
            statusText = "Статус не установлен"
        }
    }

    
    @objc func labelClicked(_ sender: Any) {
        print("UILabel clicked")
        statusTextField.isHidden = false
    }

}

