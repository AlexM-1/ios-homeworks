
import UIKit

class InfoViewController: UIViewController {


    private lazy var alertButton = CustomButton(title: "Alert", titleColor: .white) {

        [weak self] in
        let alert = UIAlertController(
                   title: "Hello",
                   message: "I'm message of alert",
                   preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "Default", style: .default, handler: { _ in print("pressed Default") }))
               alert.addAction(UIAlertAction(title: "Destructive", style: .destructive, handler: { _ in print("pressed Destructive")
                   
               }))
               alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in print("pressed Cancel") }))

        self?.present(alert, animated: true, completion: nil)

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        navigationItem.title = "InfoView"
        view.backgroundColor = .systemPink
        view.addSubview(self.alertButton)
        createViewConstraint()
    }
    
    
    private func createViewConstraint(){
        
        NSLayoutConstraint.activate([
            alertButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -100),
            alertButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            alertButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            alertButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    
}
