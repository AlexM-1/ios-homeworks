import UIKit
import SnapKit

class ProfileHeaderView: UIView {
    
    private var statusText: String = "Waiting for something..."
    
    private let tapGestureRecognizer = UITapGestureRecognizer()
    
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
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
    }
    
    private func createViewConstraint() {
        
        imageView.snp.makeConstraints { (make) -> Void in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(16)
            make.width.height.equalTo(100)
        }
        
        
        self.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(226)
            make.width.equalTo(UIScreen.main.bounds.width)
            
        }
        
        nameLabel.snp.makeConstraints { (make) -> Void in
            make.leading.equalToSuperview().offset(132)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(27)
        }
        
        statusLabel.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(nameLabel.snp.leading)
            make.trailing.equalTo(nameLabel.snp.trailing)
            make.top.equalToSuperview().offset(84)
        }
        
        setStatusButton.snp.makeConstraints { (make) -> Void in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(160)
            make.height.equalTo(50)
        }
        
        statusTextField.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(nameLabel.snp.leading)
            make.trailing.equalTo(nameLabel.snp.trailing)
            make.top.equalToSuperview().offset(110)
            make.height.equalTo(40)
        }
        
        closeButton.snp.makeConstraints { (make) -> Void in
            make.top.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.width.height.equalTo(27)
        }
        
        transparentView.snp.makeConstraints { (make) -> Void in
            make.top.leading.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width)
            make.height.equalTo(UIScreen.main.bounds.height)
        }
        
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
                
                self.imageView.snp.updateConstraints { (make) in
                    make.leading.equalToSuperview().offset(16)
                    make.top.equalToSuperview().offset(16)
                    make.width.height.equalTo(100)
                }
                
                
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
            
            
            self.imageView.snp.updateConstraints { (make) in
                make.leading.equalToSuperview()
                make.top.equalToSuperview().offset((UIScreen.main.bounds.height - UIScreen.main.bounds.width) / 2)
                make.width.height.equalTo(UIScreen.main.bounds.width)
            }
            
            
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

