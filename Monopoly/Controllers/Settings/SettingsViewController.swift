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
    let fromSettingsToImageSelectorSegue = "fromSettingsToImageSelector"
    let fromSettingsToCashSegue = "fromSettingsToCash"
    let placeholderImageName = "placeholder"
    
    var startMoney: Int64 = 1500
    
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

    func formAvatarArray() -> [Player] {
        var avatarArray = [Player]()
        avatarArray.append(Player(name: "", money: 0, image: UIImage(named: "boat")!))
        avatarArray.append(Player(name: "", money: 0, image: UIImage(named: "car")!))
        avatarArray.append(Player(name: "", money: 0, image: UIImage(named: "cat")!))
        avatarArray.append(Player(name: "", money: 0, image: UIImage(named: "dog")!))
        avatarArray.append(Player(name: "", money: 0, image: UIImage(named: "hat")!))
        avatarArray.append(Player(name: "", money: 0, image: UIImage(named: "naperstok")!))
        avatarArray.append(Player(name: "", money: 0, image: UIImage(named: "tachka")!))
        avatarArray.append(Player(name: "", money: 0, image: UIImage(named: "utug")!))
        return avatarArray
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == self.fromSettingsToImageSelectorSegue {
            guard let destination = segue.destination as? SelectImageController,
                  let indexPath = sender as? IndexPath
            else {
                return
            }
            destination.setParams(playersToSelect: formAvatarArray(), indexPath: indexPath)
            destination.delegate = self
        }
    }

    @IBAction func pressNextButton(sender: UIButton) {
        performSegue(withIdentifier: fromSettingsToCashSegue, sender: self)
    }


}

//MARK:- UITableViewDelegate
extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataModel.shared.getPlayerArrayCount() + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == (tableView.numberOfRows(inSection: 0) - 1) {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: settingsAddCellIdentifier) as? AddNewSettingsItemCell
            else {
                return UITableViewCell()
            }
            cell.delegate = self
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: settingsCellIdentifier) as? SettingsCellTableViewCell,
              let player = DataModel.shared.getPlayer(atIndex: indexPath.row)
        else {
            return UITableViewCell()
        }
        
        cell.setPlayer(player: player, indexPath: indexPath)
        cell.delegate = self
        
        return cell
    }
    
}

//MARK:- SettingsCellDelegate
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
        if DataModel.shared.modifyPlayer(name: name, money: nil, image: nil, atIndex: indexPath.row) {
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
        if DataModel.shared.modifyPlayer(name: nil, money: tempMoney.longLongValue, image: nil, atIndex: indexPath.row) {
            print("modify successfully")
        }
        else {
            print("modify failed")
        }
    }
    
    func pressOnImage(indexPath: IndexPath) {
        self.performSegue(withIdentifier: fromSettingsToImageSelectorSegue, sender: indexPath)
    }
}

//MARK:- AddNewSettingsItemDelegate
extension SettingsViewController: AddNewSettingsItemDelegate {
    func addNewSettingsItem() {
        print("add")
        let player = Player(name: "", money: self.startMoney, image: UIImage(named: self.placeholderImageName))
        DataModel.shared.addPlayer(player: player)
        self.settingsTableView.reloadData()
    }
    
}

//MARK:- SelectImageProtocol
extension SettingsViewController: SelectImageProtocol {
    func imageSelected(image: UIImage, savedIndexPath: IndexPath, selectedIndex: IndexPath) {
        if DataModel.shared.modifyPlayer(name: nil, money: nil, image: image, atIndex: savedIndexPath.row) {
            print("modify successfully")
            self.settingsTableView.reloadData()
        }
        else {
            print("modify failed")
        }
    }
    
    
}

