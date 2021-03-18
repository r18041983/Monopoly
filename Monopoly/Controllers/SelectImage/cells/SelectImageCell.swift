//
//  SelectImageCell.swift
//  Monopoly
//
//  Created by Rodion Molchanov on 17.03.2021.
//

import UIKit

class SelectImageCell: UICollectionViewCell {

    @IBOutlet var image : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        self.image.image = nil
    }
    
    func setImageToCell(image: UIImage) {
        self.image.image = image
    }
    
    func getCellImage() -> UIImage? {
        return image.image
    }
}
