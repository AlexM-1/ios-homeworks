
import UIKit

class FeedViewController: UIViewController {

    let postButton = UIButton()

    struct Post {
        let title: String
    }

    let post = Post(title: "My post title")

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Лента"
        self.view.backgroundColor = .systemBackground

        self.postButton.setTitle("Перейти на пост", for: .normal)
        self.postButton.backgroundColor = .blue
        self.postButton.layer.cornerRadius = 12
        self.postButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        self.postButton.setTitleColor(.white, for: .normal)
        self.postButton.addTarget(self, action: #selector(postButtonTap), for: .touchUpInside)

        self.view.addSubview(self.postButton)
        self.postButton.translatesAutoresizingMaskIntoConstraints = false
        self.postButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -100).isActive = true
        self.postButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50).isActive = true
        self.postButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50).isActive = true
        self.postButton.heightAnchor.constraint(equalToConstant: 50).isActive = true

    }

    @objc func postButtonTap() {
        let postViewController = PostViewController()
        postViewController.titlePost = post.title
        self.navigationController?.pushViewController(postViewController, animated: true)
    }

}
