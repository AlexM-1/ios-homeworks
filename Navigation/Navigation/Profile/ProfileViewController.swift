
import UIKit

class ProfileViewController: UIViewController {

    private let profileHeaderView = ProfileHeaderView()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Профиль"
        view.backgroundColor = .lightGray
        view.addSubview(profileHeaderView)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        profileHeaderView.frame = CGRect(x: view.safeAreaInsets.left,
                                         y: view.safeAreaInsets.top,
                                         width: view.bounds.width - view.safeAreaInsets.left - view.safeAreaInsets.right,
                                         height: view.bounds.height - view.safeAreaInsets.top-view.safeAreaInsets.bottom)
    }
    
}
