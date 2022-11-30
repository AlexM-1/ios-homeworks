
import UIKit

class PostViewController: UIViewController {

    var titlePost: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        title = titlePost
        self.view.backgroundColor = .systemTeal
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "info"),
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: #selector(showInfo))
    }
    
    @objc func showInfo() {
        let infoViewController = InfoViewController()
        self.present(infoViewController, animated: true)
    }
}
