//
//  AvatarCollectionViewCell.swift
//  Monopoly
//
//  Created by Rodion Molchanov on 18.03.2021.
//

import UIKit

class AvatarCollectionViewCell: UICollectionViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var cashLabel: UILabel!
    @IBOutlet var avatarImageView: UIImageView!
    
    var savedIndexPath = IndexPath()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.nameLabel.text = nil
        self.cashLabel.text = nil
        self.avatarImageView.image = nil
    }

    override func prepareForReuse() {
        self.nameLabel.text = nil
        self.cashLabel.text = nil
        self.avatarImageView.image = nil
    }

    func setAvatarCell(player: Player, indexToSave: IndexPath?) {
        self.nameLabel.text = player.name
        self.cashLabel.text = String(player.money)
        switch player.money {
        case Int64.min..<0:
            self.cashLabel.textColor = UIColor.black
        case 0..<500:
            self.cashLabel.textColor = UIColor.systemRed
        case 501..<1000:
            self.cashLabel.textColor = UIColor.systemYellow
        default:
            self.cashLabel.textColor = UIColor.systemGreen
        }
        
        if let avatarImage = player.image {
            self.avatarImageView.image = avatarImage
        }
        if let indexToSave = indexToSave {
            self.savedIndexPath = indexToSave
        }
    }

    
    
}
