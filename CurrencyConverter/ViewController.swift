//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Mike Vork on 3/6/17.
//  Copyright © 2017 Mike Vork. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    let decimalSeparator = ","
    
    // conversion constants
    let poundRate = 0.69
    let yenRate = 113.94
    let euroRate = 0.89
    
    var dollarAmount = 0.0
    
    // outlets
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var poundLabel: UILabel!
    @IBOutlet weak var yenLabel: UILabel!
    @IBOutlet weak var euroLabel: UILabel!

    // called when user clicks "Clear" button
    @IBAction func clearData(_ sender: UIButton) {
        inputTextField.text = ""
        poundLabel.text = "0.00"
        yenLabel.text = "0.00"
        euroLabel.text = "0.00"
    }
    
    // called when input dollar amount field changes values
    @IBAction func dollarAmountChanged(_ sender: UITextField) {
        let originalText = inputTextField.text!
        let lastCharacter = originalText.characters.last
        let inputText = originalText.replacingOccurrences(of: decimalSeparator, with: "")
        if let amount = Double(inputText) {
            dollarAmount = amount
            inputTextField.text = formatInputDisplayString(dollarAmount)
            if let lastCharUnwrapped = lastCharacter, lastCharUnwrapped == "." {
                inputTextField.text = "\(inputTextField.text!)."  // add the trailing decimal point back
            }
        }
        
        updateUI()
    }
    
    // called when user clicks "Convert" button
    @IBAction func convertCurrency(_ sender: UIButton) {
        updateUI()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        inputTextField.delegate = self
        inputTextField.becomeFirstResponder()
        
    }

    func updateUI() {
        let inputText = inputTextField.text!.replacingOccurrences(of: decimalSeparator, with: "")
        if let amount = Double(inputText) {
            dollarAmount = amount
        }
        
        poundLabel.text = formatDisplayString(dollarAmount * poundRate)
        yenLabel.text = formatDisplayString(dollarAmount * yenRate)
        euroLabel.text = formatDisplayString(dollarAmount * euroRate)
        dollarAmount = 0.0
    }
    
    private func formatInputDisplayString(_ doubleValue: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumIntegerDigits = 1
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = 20
        numberFormatter.currencyDecimalSeparator = decimalSeparator
        return numberFormatter.string(from: NSNumber(floatLiteral: doubleValue))!
    }
    
    private func formatDisplayString(_ doubleValue: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumIntegerDigits = 1
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.currencyDecimalSeparator = decimalSeparator
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

