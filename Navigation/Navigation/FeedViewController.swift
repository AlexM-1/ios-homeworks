
import UIKit

class FeedViewController: UIViewController {

    private lazy var postButton: UIButton = {
        let button = UIButton()
        button.setTitle("Перейти на пост", for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 12
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(postButtonTap), for: .touchUpInside)
        return button
    }()

    private lazy var postButtonTwo: UIButton = {
        let button = UIButton()
        button.setTitle("Перейти на пост", for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 12
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(postButtonTap), for: .touchUpInside)
        return button
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
        //   stackView.backgroundColor = .red
        return stackView
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        title = "Лента"
        view.backgroundColor = .systemBackground
        view.addSubview(stackView)
        stackView.addArrangedSubview(postButton)
        stackView.addArrangedSubview(postButtonTwo)
        createViewConstraint()
    }

    private func createViewConstraint() {

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 120),
            stackView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -32),
            postButton.heightAnchor.constraint(equalTo: postButtonTwo.heightAnchor, multiplier: 1)
        ])
    }


    @objc func postButtonTap() {
        let postViewController = PostViewController()
        postViewController.titlePost = post.title
        self.navigationController?.pushViewController(postViewController, animated: true)
    }

}
