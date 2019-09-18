//
//  MainViewController.swift
//  ACTech
//
//  Created by mac on 9/17/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: "MainTableCell", bundle: nil), forCellReuseIdentifier: "MainTableCell")
            tableView.delegate = self
            tableView.dataSource = self
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

extension MainViewController {
    
    @IBAction func didPressedAddButton(_ sender: UIBarButtonItem) {
        ACUser.instance?.settings.append(ACSetting())
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @IBAction func didPressedLogoutButton(_ sender: UIBarButtonItem) {
        
        presentAlertWithTitle(title: "Logout", message: "Are you sure you want to log out?", options: "Cancel", "Exit") { (option) in
            
            switch option {
            case 1:
                ACUser.instance = nil
                UserDefaults.standard[.user] = nil
                self.dismiss(animated: true, completion: nil)
            default:
                break
            }
        }
    }
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64.0
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            ACUser.instance?.settings.remove(at: indexPath.item)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let setting = ACUser.instance?.settings[indexPath.item]
        let sb = UIStoryboard(name: "Main", bundle: Bundle.main)
        let settingsController = sb.instantiateViewController(withIdentifier: "EditViewController") as! EditViewController
        settingsController.setting = setting
        
        navigationController?.pushViewController(settingsController, animated: true)
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ACUser.instance?.settings.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let setting = ACUser.instance?.settings[indexPath.item]
        return MainTableCell.cell(tableView: tableView, indexPath: indexPath, setting: setting)
    }
    
}
