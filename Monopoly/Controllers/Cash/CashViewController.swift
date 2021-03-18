//
//  CashViewController.swift
//  Monopoly
//
//  Created by Rodion Molchanov on 18.03.2021.
//

import UIKit

class CashViewController: UIViewController {

    @IBOutlet weak var cashCollectionView: CashCollectionView!
    
    let reuseIdentifier = "reuseCashCellIdentifier"
    let numberCellsInRow = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.cashCollectionView.delegate = self
        self.cashCollectionView.dataSource = self
        
        self.cashCollectionView!.register(UINib(nibName: "AvatarCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        let flowLayout = self.cashCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.estimatedItemSize = .zero
    
    }
    

}


extension CashViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataModel.shared.getPlayerArrayCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? AvatarCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        
        if let player = DataModel.shared.getPlayer(atIndex: indexPath.item) {
            cell.setAvatarCell(player: player, indexToSave: indexPath)
        }
        
        return cell
    }
    
// MARK: UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        guard let cell = collectionView.cellForItem(at: indexPath) as? AvatarCollectionViewCell else {return true}
        let savedIndexPath = cell.savedIndexPath
        
        return true
    }
    
    
}

extension CashViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let flowLayout = self.cashCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left +
            flowLayout.sectionInset.right +
            (flowLayout.minimumInteritemSpacing * CGFloat(self.numberCellsInRow - 1))
        
        let size = ((collectionView.bounds.width - totalSpace) / CGFloat(numberCellsInRow))
        return CGSize(width: size, height: size)
    }
}
