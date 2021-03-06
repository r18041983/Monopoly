//
//  SelectOperationViewController.swift
//  Monopoly
//
//  Created by Rodion Molchanov on 18.03.2021.
//

import UIKit

protocol SelectOperationDelegate {
    func changesDone()
}

class SelectOperationViewController: UIViewController {
    
    @IBOutlet weak var transferToPlayer: UIButton!
    @IBOutlet weak var transferToBank: UIButton!
    @IBOutlet weak var transferToMe: UIButton!
    @IBOutlet weak var transferToAll: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    
    enum HowButtonPressed {
        case toPlayer
        case toBank
        case toMe
        case toAll
    }
    
    var howButton: HowButtonPressed = .toPlayer
    
    let fromSelectOperationToHowMoneySegue = "fromSelectOperationToHowMoney"
    let fromSelectOperationToSelectImageSegue = "fromSelectOperationToSelectImage"
    var savedIndexPath = IndexPath()
    var delegate: SelectOperationDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.transferToPlayer.layer.cornerRadius = self.transferToPlayer.frame.height / 2
        self.transferToBank.layer.cornerRadius = self.transferToBank.frame.height / 2
        self.transferToMe.layer.cornerRadius = self.transferToMe.frame.height / 2
        self.transferToAll.layer.cornerRadius = self.transferToAll.frame.height / 2
        self.closeButton.layer.cornerRadius = 15
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == fromSelectOperationToHowMoneySegue {
            let destination = segue.destination as! HowMoneyViewController
            if let selectedIndexToSave = sender as? IndexPath {
                destination.savedIndexPath = selectedIndexToSave
            }
            destination.delegate = self
        }
        
        if segue.identifier == fromSelectOperationToSelectImageSegue {
            let destination = segue.destination as! SelectImageController
            var tempArray = [Player]()
            for index in 0...DataModel.shared.getPlayerArrayCount() {
                if let player = DataModel.shared.getPlayer(atIndex: index) {
                    tempArray.append(player)
                }
            }
            destination.setParams(playersToSelect: tempArray, indexPath: IndexPath())
            destination.delegate = self
        }
    }
    
    @IBAction func pressCloseButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pressTransferToPlayer(_ sender: UIButton) {
        self.howButton = .toPlayer
        performSegue(withIdentifier: fromSelectOperationToSelectImageSegue, sender: self)
    }
    
    @IBAction func pressTransferToBank(_ sender: UIButton) {
        self.howButton = .toBank
        performSegue(withIdentifier: fromSelectOperationToHowMoneySegue, sender: self)
    }
    
    @IBAction func pressTransferToMe(_ sender: UIButton) {
        self.howButton = .toMe
        performSegue(withIdentifier: fromSelectOperationToHowMoneySegue, sender: self)
    }
    
    @IBAction func pressTransferToAll(_ sender: UIButton) {
        self.howButton = .toAll
        performSegue(withIdentifier: fromSelectOperationToHowMoneySegue, sender: self)
    }
    
}

//MARK:- HowMoneyDelegate
extension SelectOperationViewController: HowMoneyDelegate {
    func moneyDone(howMoney: Int64, saveIndexPath: IndexPath?) {
        let player = DataModel.shared.getPlayer(atIndex: savedIndexPath.item)
        var playerMoney = (player?.money ?? 0)
        
        switch self.howButton {
        case .toBank:
            playerMoney -= howMoney
        case .toMe:
            playerMoney += howMoney
        case .toAll:
            for index in 0...DataModel.shared.getPlayerArrayCount() {
                if index != self.savedIndexPath.item {
                    let toPlayer = DataModel.shared.getPlayer(atIndex: index)
                    var toPlayerMoney = (toPlayer?.money ?? 0)
                    toPlayerMoney += howMoney
                    let _ = DataModel.shared.modifyPlayer(name: nil, money: toPlayerMoney, image: nil, atIndex: index)
                    playerMoney -= howMoney
                }
            }
        case .toPlayer:
            if let index = saveIndexPath?.item, let toPlayer = DataModel.shared.getPlayer(atIndex: index) {
                let toPlayerMoney = toPlayer.money + howMoney
                let _ = DataModel.shared.modifyPlayer(name: nil, money: toPlayerMoney, image: nil, atIndex: index)
                playerMoney -= howMoney
            }
        }
        
        if DataModel.shared.modifyPlayer(name: nil, money: playerMoney, image: nil, atIndex: savedIndexPath.item) {
            print("Success modification")
        }
        self.dismiss(animated: true, completion: {self.delegate?.changesDone()})
    }
    
    
}

//MARK:- SelectImageProtocol
extension SelectOperationViewController: SelectImageProtocol {
    func imageSelected(image: UIImage, savedIndexPath: IndexPath, selectedIndex: IndexPath) {
        performSegue(withIdentifier: self.fromSelectOperationToHowMoneySegue, sender: selectedIndex)
    }
    
}
