
import UIKit

class FeedViewController: UIViewController {

    private lazy var postButton = CustomButton(title: "Перейти на пост", titleColor: .white) {

        [weak self] in
        let postViewController = PostViewController()
        postViewController.titlePost = self?.post.title ?? ""
        self?.navigationController?.pushViewController(postViewController, animated: true)
    }


    private lazy var postButtonTwo = CustomButton(title: "Перейти на пост", titleColor: .white) {

        [weak self] in
        let postViewController = PostViewController()
        postViewController.titlePost = self?.post.title ?? ""
        self?.navigationController?.pushViewController(postViewController, animated: true)
    }


    private lazy var checkGuessTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.placeholder = "Input secret word..."
        let spacerView = UIView(frame:CGRect(x:0, y:0, width:10, height:10))
        textField.leftViewMode = UITextField.ViewMode.always
        textField.leftView = spacerView
        textField.isSecureTextEntry = true
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.spellCheckingType = .no
        return textField
    }()


    private lazy var checkGuessButton = CustomButton(title: "Проверить", titleColor: .white) {

        [weak self] in
        guard self?.checkGuessTextField.text != "" else {
            self?.checkWordLabel.text = "вы ввели пустое значение"
            self?.checkWordLabel.textColor = .systemGray5
            return
        }

        let feedModel = FeedModel()
        if feedModel.check(word: self?.checkGuessTextField.text ?? "") {
            self?.checkWordLabel.text = "верно"
            self?.checkWordLabel.textColor = .systemGreen
        }

        else {
            self?.checkWordLabel.text = "неверно"
            self?.checkWordLabel.textColor = .red
        }
    }


    private lazy var checkWordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()



    struct Post {
        let title: String
    }

    private var post = Post(title: "My post title")

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(stackView)
        stackView.addArrangedSubview(postButton)
        stackView.addArrangedSubview(postButtonTwo)

        view.addSubview(checkGuessTextField)
        view.addSubview(checkGuessButton)
        view.addSubview(checkWordLabel)

        createViewConstraint()
    }

    private func createViewConstraint() {

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 120),
            stackView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -32),
            postButton.heightAnchor.constraint(equalTo: postButtonTwo.heightAnchor, multiplier: 1),


            checkGuessTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            checkGuessTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            checkGuessTextField.heightAnchor.constraint(equalToConstant: 50),


            checkGuessButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            checkGuessButton.topAnchor.constraint(equalTo: checkGuessTextField.bottomAnchor, constant: 20),
            checkGuessButton.heightAnchor.constraint(equalToConstant: 50),

            checkWordLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            checkWordLabel.topAnchor.constraint(equalTo: checkGuessButton.bottomAnchor, constant: 20)

        ])
    }



}
