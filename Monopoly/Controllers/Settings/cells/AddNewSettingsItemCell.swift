//
//  AddNewSettingsItemCell.swift
//  Monopoly
//
//  Created by Rodion Molchanov on 09.03.2021.
//

import UIKit

protocol AddNewSettingsItemDelegate {
    func addNewSettingsItem()
}


class AddNewSettingsItemCell: UITableViewCell {

    var delegate: AddNewSettingsItemDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func pressAddNewPlayer(button: UIButton) {
        delegate?.addNewSettingsItem()
    }
    
    
    
}
