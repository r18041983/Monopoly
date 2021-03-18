//
//  HowMoneyViewController.swift
//  Monopoly
//
//  Created by Rodion Molchanov on 18.03.2021.
//

import UIKit

protocol HowMoneyDelegate {
    func moneyDone(howMoney: Int64, saveIndexPath: IndexPath?)
}

class HowMoneyViewController: UIViewController {

    @IBOutlet weak var moneyTextField: UITextField!
    @IBOutlet weak var doneButton: UIButton!
    
    var delegate: HowMoneyDelegate?
    var savedIndexPath : IndexPath?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.moneyTextField.becomeFirstResponder()
        self.doneButton.layer.cornerRadius = 20
    }
    
    @IBAction func pressDoneButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: {
            if let money = self.moneyTextField.text {
                self.delegate?.moneyDone(howMoney: Int64(money) ?? 0, saveIndexPath: self.savedIndexPath)
            }
        })
    }

    
}
