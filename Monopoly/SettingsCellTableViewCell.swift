//
//  SettingsCellTableViewCell.swift
//  Monopoly
//
//  Created by Rodion Molchanov on 09.03.2021.
//

import UIKit

protocol SettingsCellDelegate {
    func nameDidChange(name: String, indexPath: IndexPath)
    func moneyDidChange(money: String, indexPath: IndexPath)
    func deleteItem(name: String, money: String, indexPath: IndexPath)
}


class SettingsCellTableViewCell: UITableViewCell {

    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var moneyTextField: UITextField!
    @IBOutlet var deleteItemButton: UIButton!
    
    var savedIndexPath: IndexPath?
    var delegate: SettingsCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.nameTextField.delegate = self
        self.moneyTextField.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super .prepareForReuse()
        self.nameTextField.text = nil
        self.moneyTextField.text = nil
        self.savedIndexPath = nil
    }
    
    func setPlayer(player: Player, indexPath: IndexPath) {
        self.nameTextField.text = player.name
        self.moneyTextField.text = String(player.money)
        self.savedIndexPath = indexPath
    }

    @IBAction func pressDeleteItemButton(button: UIButton){
        guard let savedIndexPath = savedIndexPath else {return}
        delegate?.deleteItem(name: nameTextField.text ?? "", money: moneyTextField.text ?? "", indexPath: savedIndexPath)
    }
    
}

extension SettingsCellTableViewCell: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func modifyTextField(_ textField: UITextField) {
        guard let savedIndexPath = savedIndexPath else {return}
        
        if textField == nameTextField {
            self.delegate?.nameDidChange(name: textField.text ?? "", indexPath: savedIndexPath)
        }
        else if textField == moneyTextField {
            self.delegate?.moneyDidChange(money: textField.text ?? "", indexPath: savedIndexPath)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        modifyTextField(textField)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        modifyTextField(textField)
        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        modifyTextField(textField)
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        modifyTextField(textField)
    }
    
//    - (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;   // return NO to not change text
//
//    - (void)textFieldDidChangeSelection:(UITextField *)textField API_AVAILABLE(ios(13.0), tvos(13.0));


}
