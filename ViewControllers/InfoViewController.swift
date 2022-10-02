
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

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.text = ""
        return label
    }()

    private lazy var planetLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.text = ""
        label.numberOfLines = 0
        return label
    }()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        navigationItem.title = "InfoView"
        view.backgroundColor = .systemPink
        view.addSubview(self.alertButton)
        view.addSubview(self.nameLabel)
        view.addSubview(self.planetLabel)
        createViewConstraint()

        //nameLabel.text = userArray.randomElement()?.title
        nameLabel.text = userArray.first?.title
        planetLabel.text = "период обращения планеты Татуин вокруг своей звезды - \(orbitalPeriod)"
    }
    
    
    private func createViewConstraint(){
        
        NSLayoutConstraint.activate([
            alertButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -100),
            alertButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            alertButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            alertButton.heightAnchor.constraint(equalToConstant: 50),

            nameLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20),

            planetLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            planetLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            planetLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50)



        ])
    }


    
}
