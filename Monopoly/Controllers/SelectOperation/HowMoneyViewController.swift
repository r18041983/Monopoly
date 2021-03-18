//
//  HowMoneyViewController.swift
//  Monopoly
//
//  Created by Rodion Molchanov on 18.03.2021.
//

import UIKit

protocol HowMoneyDelegate {
    func moneyDone(howMoney: Int64)
}

class HowMoneyViewController: UIViewController {

    @IBOutlet weak var moneyTextField: UITextField!
    @IBOutlet weak var doneButton: UIButton!
    
    var delegate: HowMoneyDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.moneyTextField.becomeFirstResponder()
        self.moneyTextField.delegate = self
        self.doneButton.layer.cornerRadius = 20
    }
    
    @IBAction func pressDoneButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: {
            if let money = self.moneyTextField.text {
                self.delegate?.moneyDone(howMoney: Int64(money) ?? 0)
            }
        })
    }

    
}

extension HowMoneyViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        print()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print()
    }
    
    
}
