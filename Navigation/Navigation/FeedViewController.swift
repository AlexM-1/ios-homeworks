
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

    struct Post {
        let title: String
    }

    let post = Post(title: "My post title")

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Лента"
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(self.postButton)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        postButton.frame = CGRect(x: view.safeAreaInsets.left + 50,
                                  y: view.bounds.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom - 20,
                                  width: view.bounds.width - view.safeAreaInsets.left - view.safeAreaInsets.right - 100,
                                  height: 50)
    }

    @objc func postButtonTap() {
        let postViewController = PostViewController()
        postViewController.titlePost = post.title
        self.navigationController?.pushViewController(postViewController, animated: true)
    }

}
