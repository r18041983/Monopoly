//
//  ViewController.swift
//  Monopoly
//
//  Created by Rodion Molchanov on 09.03.2021.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet var settingsTableView: UITableView!
    
    let settingsCellIdentifier = "SettingsCell"
    let settingsAddCellIdentifier = "AddNewSettingsItem"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsTableView.delegate = self
        settingsTableView.dataSource = self
        
        settingsTableView.register(UINib(nibName: "SettingsCellTableViewCell", bundle: nil), forCellReuseIdentifier: settingsCellIdentifier)
        settingsTableView.register(UINib(nibName: "AddNewSettingsItemCell", bundle: nil), forCellReuseIdentifier: settingsAddCellIdentifier)

        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))

        self.settingsTableView.addGestureRecognizer(hideKeyboardGesture)
        self.view.addGestureRecognizer(hideKeyboardGesture)
    
    }
    
    @objc func hideKeyboard() {
            self.settingsTableView?.endEditing(true)
    }

}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataModel.shared.getPlayerArrayCount() + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == (tableView.numberOfRows(inSection: 0) - 1) {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: settingsAddCellIdentifier) as? AddNewSettingsItemCell
            else
            {
                return UITableViewCell()
            }
            cell.delegate = self
            return cell
        }
        
        
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: settingsCellIdentifier) as? SettingsCellTableViewCell
        else
        {
            return UITableViewCell()
        }
    
        cell.setPlayer(player: DataModel.shared.getPlayer(atIndex: indexPath.row), indexPath: indexPath)
        cell.delegate = self
        return cell
    
    }
    
}


extension SettingsViewController: SettingsCellDelegate {
    func deleteItem(name: String, money: String, indexPath: IndexPath) {
        print("delete item " + String(indexPath.row))
        if DataModel.shared.deletePlayer(atIndex: indexPath.row) {
            self.settingsTableView.reloadData()
        }
    }
    
    func nameDidChange(name: String, indexPath: IndexPath) {
        print(name)
        print(indexPath)
        if DataModel.shared.modifyPlayerName(name: name, atIndex: indexPath.row) {
            print("modify successfully")
        }
        else {
            print("modify failed")
        }
    }
    
    
    func moneyDidChange(money: String, indexPath: IndexPath) {
        print(money)
        print(indexPath)
        let tempMoney = money as NSString
        if DataModel.shared.modifyPlayerMoney(money: tempMoney.longLongValue, atIndex: indexPath.row) {
            print("modify successfully")
        }
        else {
            print("modify failed")
        }
    }
}


extension SettingsViewController: AddNewSettingsItemDelegate {
    func addNewSettingsItem() {
        print("add")
        DataModel.shared.addCleanPlayer()
        self.settingsTableView.reloadData()
    }
    
    
}
