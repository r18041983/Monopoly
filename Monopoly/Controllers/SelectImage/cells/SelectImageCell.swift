//
//  SelectImageCell.swift
//  Monopoly
//
//  Created by Rodion Molchanov on 17.03.2021.
//

import UIKit

class SelectImageCell: UICollectionViewCell {

    @IBOutlet var image : UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var savedIndexPath = IndexPath()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        self.image.image = nil
        self.nameLabel.text = ""
    }
    
    func setDataToCell(image: UIImage, name: String?, indexPath: IndexPath) {
        self.image.image = image
        if let name = name {
            self.nameLabel.text = name
        }
        self.savedIndexPath = indexPath
    }
    
    func getCellImage() -> UIImage? {
        return image.image
    }

    func getSavedIndexPath() -> IndexPath {
        return savedIndexPath
    }
}
