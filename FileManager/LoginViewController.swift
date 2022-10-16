//
//  LoginViewController.swift
//  FileManager
//
//  Created by Alex M on 14.10.2022.
//

import UIKit


class LoginViewController: UIViewController {

    let model = Model()

    private var password: String? = nil

    var closure: (()->Void)?

    @IBOutlet weak var textField: UITextField!

    @IBOutlet weak var loginButton: UIButton!

    @IBAction func loginButtonAction(_ sender: UIButton) {

        switch model.state {

        case .passwordNotCreated, .changePassword:

            if self.password == nil {

                if let password = textField.text,
                   password.count >= 4 {
                    self.password = password
                    textField.text = ""
                    loginButton.setTitle("Повторите пароль", for: .normal)
                } else {
                    showMessage("Пароль должен состоять минимум из четырёх символов", title: "Пароль не установлен")
                }

            } else {

                if textField.text == self.password {

                    if model.state == .passwordNotCreated {
                        model.keyChain.addPassword(login: model.userName, password: textField.text!, serviceName: "")
                        let tbc = setupTabBarController()
                        navigationController?.pushViewController(tbc, animated: true)
                    }

                    if model.state == .changePassword {
                        model.keyChain.updatePassword(login: model.userName, newPassword: textField.text!, serviceName: "")
                        self.closure?()
                    }
                }

                else { showMessage("Пароли не совпадают", title: "Пароль не установлен")
                    self.password = nil
                    textField.text = ""
                    loginButton.setTitle("Создать пароль", for: .normal)
                }
            }

        case .passwordIsSaved:

            let pass = model.keyChain.getPassword(login: model.userName, serviceName: "")
            if pass == textField.text {

                let tbc = setupTabBarController()
                navigationController?.pushViewController(tbc, animated: true)

            } else {
                showMessage("Неверный пароль", title: nil)
            }

        }}



    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    func setup() {

        if model.keyChain.getPassword(login: model.userName, serviceName: "") == nil {
            self.model.state = .passwordNotCreated
        } else if self.model.state != .changePassword {
            self.model.state = .passwordIsSaved
        }


        switch self.model.state {
        case .passwordNotCreated, .changePassword:
            self.loginButton.setTitle("Создать пароль", for: .normal)
        case .passwordIsSaved:
            self.loginButton.setTitle("Введите пароль", for: .normal)
        }
    }

    func showMessage (_ text: String, title: String? = "Message") {
        let alertController = UIAlertController(title: title, message: text, preferredStyle: .alert)
        let actionOK = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(actionOK)
        present(alertController, animated: true)
    }



    private func setupTabBarController() -> UITabBarController {

        let tabBarController = UITabBarController()

        let vc1 = storyboard?.instantiateViewController(withIdentifier: "tableControllerSID") as! TableViewController
        let vc2 = storyboard?.instantiateViewController(withIdentifier: "settingsControllerSID") as! SettingsViewController

        let nc1 = UINavigationController(rootViewController: vc1)
        let nc2 = UINavigationController(rootViewController: vc2)


        vc1.tabBarItem = UITabBarItem(title: "Список файлов", image: UIImage(systemName: "internaldrive"), selectedImage: nil)
        vc2.tabBarItem = UITabBarItem(title: "Настройки", image: UIImage(systemName: "slider.horizontal.3"), selectedImage: nil)

        tabBarController.setViewControllers([nc1, nc2], animated: true)

        tabBarController.navigationController?.isNavigationBarHidden = true

        let tabBarAppearance: UITabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithDefaultBackground()
        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance

        let navBarAppearance: UINavigationBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithDefaultBackground()

        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance

        return tabBarController
    }
}
