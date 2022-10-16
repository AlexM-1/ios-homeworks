//
//  SettingsViewController.swift
//  FileManager
//
//  Created by Alex M on 14.10.2022.
//

import UIKit

class SettingsViewController: UITableViewController {

    private var isSortingByName: Bool {
        set {
            UserDefaults.standard.setValue(newValue, forKey: "SortingTypeKey")
            UserDefaults.standard.synchronize()
        }

        get {
            return UserDefaults.standard.bool(forKey: "SortingTypeKey")
        }
    }


    @IBAction func sortSwitchAction(_ sender: UISwitch) {
        isSortingByName = sender.isOn
        NotificationCenter.default.post(name: NSNotification.Name("sortingByNameIsChanged"), object: nil)
    }

    @IBOutlet weak var sortSwitch: UISwitch!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Настройки"
        self.view.backgroundColor = .systemGray6
        sortSwitch.setOn(self.isSortingByName, animated: false)
    }


    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            let vc = storyboard?.instantiateViewController(withIdentifier: "loginControllerSID") as! LoginViewController
            vc.model.state = .changePassword
            vc.closure = { [weak self] in
                self?.dismiss(animated: true)
                self?.showMessage("Пароль успешно изменен", title: nil)

            }
            present(vc, animated: true)

        }
        tableView.deselectRow(at: indexPath, animated: true)

    }

    func showMessage (_ text: String, title: String? = "Сообщение") {
        let alertController = UIAlertController(title: title, message: text, preferredStyle: .alert)
        let actionOK = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(actionOK)
        present(alertController, animated: true)
    }

}
