//
//  CashViewController.swift
//  Monopoly
//
//  Created by Rodion Molchanov on 18.03.2021.
//

import UIKit

class CashViewController: UIViewController {

    @IBOutlet weak var cashCollectionView: UICollectionView!
    
    let reuseIdentifier = "reuseCashCellIdentifier"
    let numberCellsInRow = 3
    let fromCashToSelectOperationSegue = "fromCashToSelectOperation"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cashCollectionView.delegate = self
        self.cashCollectionView.dataSource = self
        self.cashCollectionView!.register(UINib(nibName: "AvatarCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        
        let flowLayout = self.cashCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.estimatedItemSize = .zero
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == self.fromCashToSelectOperationSegue {
            guard let destination = segue.destination as? SelectOperationViewController else {return}
            guard let indexPath = sender as? IndexPath else {return}
            destination.savedIndexPath = indexPath
            destination.delegate = self
        }
    }
}

// MARK:- UICollectionViewDelegate
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
    
// MARK:- UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        guard let cell = collectionView.cellForItem(at: indexPath) as? AvatarCollectionViewCell else {return true}
        performSegue(withIdentifier: fromCashToSelectOperationSegue, sender: cell.savedIndexPath)
        return true
    }
    
    
}
// MARK:- UICollectionViewDelegateFlowLayout
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

// MARK:- SelectOperationDelegate
extension CashViewController: SelectOperationDelegate {
    func changesDone() {
        self.cashCollectionView.reloadData()
    }
}
