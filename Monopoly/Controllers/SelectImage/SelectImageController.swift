//
//  SelectImageController.swift
//  Monopoly
//
//  Created by Rodion Molchanov on 17.03.2021.
//

import UIKit

protocol SelectImageProtocol {
    func imageSelected(image: UIImage, savedIndexPath: IndexPath)
}

private let reuseIdentifier = "reuseStandartCell"

class SelectImageController: UICollectionViewController {

    private var imagesArray = [UIImage]()
    private let numberCellsInRow = 3
    private var savedIndexPath = IndexPath()
    
    var delegate : SelectImageProtocol?
    
    func setParams(imagesToSelect : [UIImage], indexPath: IndexPath) {
        self.imagesArray = imagesToSelect
        self.savedIndexPath = indexPath
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView!.register(UINib(nibName: "SelectImageCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        let flowLayout = self.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.estimatedItemSize = .zero
    }

// MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? SelectImageCell
        else {
            return UICollectionViewCell()
            
        }
        cell.setImageToCell(image: imagesArray[indexPath.item])
        return cell
    }

// MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        guard let cell = collectionView.cellForItem(at: indexPath) as? SelectImageCell, let image = cell.getCellImage() else {return true}
        self.dismiss(animated: true, completion: {self.delegate?.imageSelected(image: image, savedIndexPath: self.savedIndexPath)})
        return true
    }
    
}

// MARK: UICollectionViewDelegateFlowLayout
extension SelectImageController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let flowLayout = self.collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left +
            flowLayout.sectionInset.right +
            (flowLayout.minimumInteritemSpacing * CGFloat(self.numberCellsInRow - 1))
        
        let size = ((collectionView.bounds.width - totalSpace) / CGFloat(numberCellsInRow))
        return CGSize(width: size, height: size)
    }
}
