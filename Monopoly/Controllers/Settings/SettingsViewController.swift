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

    func formAvatarArray() -> [UIImage] {
        var avatarArray = [UIImage]()
        avatarArray.append(UIImage(named: "boat")!)
        avatarArray.append(UIImage(named: "boots")!)
        avatarArray.append(UIImage(named: "car")!)
        avatarArray.append(UIImage(named: "cat")!)
        avatarArray.append(UIImage(named: "dog")!)
        avatarArray.append(UIImage(named: "hat")!)
        avatarArray.append(UIImage(named: "naperstok")!)
        avatarArray.append(UIImage(named: "tachka")!)
        avatarArray.append(UIImage(named: "utug")!)
        return avatarArray
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == self.fromSettingsToImageSelectorSegue {
            guard let destination = segue.destination as? SelectImageController else {return}
            guard let indexPath = sender as? IndexPath else {return}
            destination.setParams(imagesToSelect: formAvatarArray(), indexPath: indexPath)
            destination.delegate = self
        }
    }

    @IBAction func pressNextButton(sender: UIButton) {
        performSegue(withIdentifier: fromSettingsToCashSegue, sender: self)
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
        
        guard let player = DataModel.shared.getPlayer(atIndex: indexPath.row) else {return UITableViewCell()}
        
  
        cell.setPlayer(player: player, indexPath: indexPath)
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


extension SettingsViewController: AddNewSettingsItemDelegate {
    func addNewSettingsItem() {
        print("add")
        let player = Player(name: "", money: self.startMoney, image: UIImage(named: self.placeholderImageName))
        DataModel.shared.addPlayer(player: player)
        self.settingsTableView.reloadData()
    }

    
}


extension SettingsViewController: SelectImageProtocol {
    func imageSelected(image: UIImage, savedIndexPath: IndexPath) {
        if DataModel.shared.modifyPlayer(name: nil, money: nil, image: image, atIndex: savedIndexPath.row) {
            print("modify successfully")
            self.settingsTableView.reloadData()
        }
        else {
            print("modify failed")
        }
    }
    
    
}
