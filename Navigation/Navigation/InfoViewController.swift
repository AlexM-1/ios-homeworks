
import UIKit

class InfoViewController: UIViewController {

    private lazy var alertButton: UIButton = {
        let button = UIButton()
        button.setTitle("Alert", for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 12
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(alertButtonTap), for: .touchUpInside)
        return button
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        title = "InfoView"
        view.backgroundColor = .systemPink
        view.addSubview(alertButton)

    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        alertButton.frame = CGRect(x: view.safeAreaInsets.left + 20,
                                   y: view.bounds.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom - 70,
                                   width: view.bounds.width - view.safeAreaInsets.left - view.safeAreaInsets.right - 40,
                                   height: 50)
    }


    @objc func alertButtonTap() {
        let alert = UIAlertController(
            title: "Hello",
            message: "I'm message of alert",
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Default", style: .default, handler: { _ in print("pressed Default") }))
        alert.addAction(UIAlertAction(title: "Destructive", style: .destructive, handler: { _ in print("pressed Destructive") }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in print("pressed Cancel") }))
        self.present(alert, animated: true, completion: nil)
    }

}
