
import UIKit

class PostViewController: UIViewController {

    var titlePost: String = "Anonymous"

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = titlePost
        self.view.backgroundColor = .systemOrange
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "info"),
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: #selector(info))
    }
    
    @objc func info() {
        let infoViewController = InfoViewController()
        let navigationController = UINavigationController(rootViewController: infoViewController)
        self.present(navigationController, animated: true)

    }


}
