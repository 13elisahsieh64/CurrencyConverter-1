//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Mike Vork on 3/6/17.
//  Copyright © 2017 Mike Vork. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    // conversion constants
    let poundRate = 0.69
    let yenRate = 113.94
    let euroRate = 0.89
    
    var dollarAmount = 0.0
    
    @IBAction func clearData(_ sender: UIButton) {
        inputTextField.text = ""
        poundLabel.text = "0.00"
        yenLabel.text = "0.00"
        euroLabel.text = "0.00"
    }
    
    
    @IBAction func convertCurrency(_ sender: UIButton) {
        updateUI()
    }
    
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var poundLabel: UILabel!
    @IBOutlet weak var yenLabel: UILabel!
    @IBOutlet weak var euroLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        inputTextField.delegate = self
    }

    func updateUI() {
        if let amount = Double(inputTextField.text!) {
            dollarAmount = amount
        }
        
        poundLabel.text = formatDisplayString(dollarAmount * poundRate)
        yenLabel.text = formatDisplayString(dollarAmount * yenRate)
        euroLabel.text = formatDisplayString(dollarAmount * euroRate)
        dollarAmount = 0.0
    }
    
    private func formatDisplayString(_ doubleValue: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumIntegerDigits = 1
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.currencyDecimalSeparator = ","
        return numberFormatter.string(from: NSNumber(floatLiteral: doubleValue))!
    }
    
    
    // MARK: UITextFieldDelegate methods
    
    // Process pressing of 'return' key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        updateUI()
        return true
    }
    
    // Process user touch outside text field
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        updateUI()
    }
    


}

