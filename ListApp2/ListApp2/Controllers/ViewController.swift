//
//  ViewController.swift
//  ListApp2
//
//  Created by Şule Şengül on 4.11.2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var alertController = UIAlertController()
    
    @IBOutlet weak var tableView: UITableView!
    
    var data = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "defaultCell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    
    @IBAction func didRemoveBarButtonItemTapped(_ sender: UIBarButtonItem) {
        presentAlert(title: "Uyarı!",
                     message: "Listedeki bütün öğeleri silmek istediğinizden emin misiniz?",
                     defaultButtonTitle: "Evet",
                     cancelButtonTitle: "Vazgeç") { _ in
            self.data.removeAll()
            self.tableView.reloadData()
        }
    }
    
    @IBAction func didAddBarButtonItemTapped(_ sender: UIBarButtonItem){
        presentAddAlert()
    }
    
    func presentAddAlert() {
        presentAlert(title: "Yeni eleman ekle",
                     message: nil,
                     defaultButtonTitle: "Ekle",
                     cancelButtonTitle: "Vazgeç",
                     isTextFieldAvaliable: true,
                     defaultButtonHandler: { _ in
            let text = self.alertController.textFields?.first?.text
            if text != "" {
                self.data.append((text)!)
                self.tableView.reloadData()
            } else {
                self.presentWarningAlert()
            }
        })
    }
    
    func presentWarningAlert() {
        presentAlert(title: "Uyarı!",
                     message: "Liste elemanı boş olamaz.",
                     cancelButtonTitle: "Tamam")
    }
    
    func presentAlert(title: String?,
                      message: String?,
                      preferredStyle: UIAlertController.Style = .alert,
                      defaultButtonTitle: String? = nil,
                      cancelButtonTitle: String?,
                      isTextFieldAvaliable: Bool = false,
                      defaultButtonHandler: ((UIAlertAction)-> Void)? = nil) {
        
        alertController = UIAlertController(title: "Uyarı",
                                            message: "Liste elemanı boş olamaz.",
                                            preferredStyle:.alert)
        
        if defaultButtonTitle != nil {
            let defaultButton = UIAlertAction(title: defaultButtonTitle,
                                              style: .default,
                                              handler: defaultButtonHandler)
            alertController.addAction(defaultButton)
        }
        
        let cancelButton = UIAlertAction(title: cancelButtonTitle,
                                         style: .cancel)
        
        if isTextFieldAvaliable {
            alertController.addTextField()
        }
        
        alertController.addAction(cancelButton)
        
        present(alertController, animated: true)
    }
}

