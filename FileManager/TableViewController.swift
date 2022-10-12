//
//  TableViewController.swift
//  FileManager
//
//  Created by Alex M on 11.10.2022.
//

import UIKit

class TableViewController: UITableViewController {

    var url: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]

    var files: [URL] {
        return (try? FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil)) ?? []
    }

    @IBAction func addFotoAction(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true)
    }


    @IBAction func addFolderAction(_ sender: Any) {
        let alertController = UIAlertController(title: "Create new folder", message: nil, preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Folder name"
        }

        let createAction = UIAlertAction(title: "Create", style: .default) { action in
            if let folderName = alertController.textFields?[0].text,
               folderName != "" {
                let newUrl = self.url.appendingPathComponent(folderName)
                do {
                    try FileManager.default.createDirectory(at: newUrl, withIntermediateDirectories: false)
                } catch {
                    self.showMessage(error.localizedDescription)
                }
                self.tableView.reloadData()
            }
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(createAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }


    @IBAction func addFileAction(_ sender: Any) {
        let alertController = UIAlertController(title: "Create new file", message: nil, preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "File name"
        }
        alertController.addTextField { textField in
            textField.placeholder = "Content"
        }

        let createAction = UIAlertAction(title: "Create", style: .default) { action in
            if let fileName = alertController.textFields?[0].text,
               let content = alertController.textFields?[1].text,
               fileName != "",
               content != "" {
                let pathToNewFile = self.url.appendingPathComponent(fileName).path

                guard !FileManager.default.fileExists(atPath: pathToNewFile) else {
                    self.showMessage("Ошибка. Файл \(fileName) уже существует")
                    return
                }
                do {
                    try NSString(string: content).write(toFile: pathToNewFile, atomically: true, encoding: String.Encoding.utf8.rawValue)
                    self.tableView.reloadData()
                } catch {
                    self.showMessage(error.localizedDescription)
                }
            }
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(createAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = url.lastPathComponent
        navigationController?.navigationBar.prefersLargeTitles = true
    }


    func showMessage (_ text: String) {
        let alertController = UIAlertController(title: "Message", message: text, preferredStyle: .alert)
        let actionOK = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(actionOK)
        present(alertController, animated: true)
    }

    // MARK: - Table view data source



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return files.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        var isFolder: ObjCBool = false

        let item = files[indexPath.row]

        FileManager.default.fileExists(atPath: item.path, isDirectory: &isFolder)


        if isFolder.boolValue == true {
            cell.detailTextLabel?.text = "FOLDER"
            cell.accessoryType = .disclosureIndicator

        } else {
            cell.detailTextLabel?.text = "File"
            cell.accessoryType = .none

        }

        cell.textLabel?.text = item.lastPathComponent

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let item = files[indexPath.row]
        var isFolder: ObjCBool = false

        FileManager.default.fileExists(atPath: item.path, isDirectory: &isFolder)

        if isFolder.boolValue == true {
            let tvc = storyboard?.instantiateViewController(withIdentifier: "tableControllerSID") as! TableViewController
            tvc.url = item
            navigationController?.pushViewController(tvc, animated: true)

        } else {

            do {
                let content = try NSString(contentsOfFile: item.path, encoding: String.Encoding.utf8.rawValue)
                showMessage(content as String)
            } catch {
                showMessage(error.localizedDescription)
            }
            tableView.deselectRow(at: indexPath, animated: true)
        }

    }



    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {
            let item = files[indexPath.row]

            do {
                _ = try FileManager.default.removeItem(at: item)
            } catch {
                showMessage(error.localizedDescription)
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        }

    }

}


extension TableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        let imageUrl = info[UIImagePickerController.InfoKey.imageURL] as! URL
        let fileName = imageUrl.lastPathComponent

        self.dismiss(animated: true)
        let data = image.pngData()
        let urlToNewFile = self.url.appendingPathComponent(fileName)

        do {
            try data?.write(to: urlToNewFile, options: .atomic)
        } catch {
            print(error.localizedDescription)
        }
        self.tableView.reloadData()
    }
}
