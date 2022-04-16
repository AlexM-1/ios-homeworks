
import UIKit

class InfoViewController: UIViewController {

    let postButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "InfoView"

        self.view.backgroundColor = .systemPink

        self.postButton.setTitle("Alert", for: .normal)
        self.postButton.backgroundColor = .blue
        self.postButton.layer.cornerRadius = 12
        self.postButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        self.postButton.setTitleColor(.white, for: .normal)
        self.postButton.addTarget(self, action: #selector(postButtonTap), for: .touchUpInside)

        self.view.addSubview(self.postButton)
        self.postButton.translatesAutoresizingMaskIntoConstraints = false
        self.postButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -100).isActive = true
        self.postButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        self.postButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        self.postButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    @objc
    func postButtonTap() {

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
