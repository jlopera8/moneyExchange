//
//  ViewController.swift
//  moneyExchange
//
//  Created by Stiven Lopera Jaramillo on 3/12/17.
//  Copyright © 2017 Stiven Lopera Jaramillo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var currencyTextField: UITextField!
    @IBOutlet var currencySegmentedControl: UISegmentedControl!
    @IBOutlet var resultLabel: UILabel!
    
    
    let dollarToCop = 2982.50
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultLabel.text = ""
        
        let currencyToSegmentedIndex = currencySegmentedControl.selectedSegmentIndex
        
        if currencyToSegmentedIndex == 0 {
            currencyTextField.placeholder = "USD"
        } else {
            currencyTextField.placeholder = "COP"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func changeCurrencySegmentedControl(_ sender: UISegmentedControl) {
    
        let currencyToSegmentedIndex = currencySegmentedControl.selectedSegmentIndex
        
        if currencyToSegmentedIndex == 0 {
            currencyTextField.placeholder = "USD"
        } else {
            currencyTextField.placeholder = "COP"
        }
    }

    @IBAction func convertButton(_ sender: UIButton) {
        
        resultLabel.text = ""
        
        let currencyToSegmentedIndex = currencySegmentedControl.selectedSegmentIndex
        
        let currencyToConvert : Double
        
        let convertedCurrency : Double
        
        if validateString(string: currencyTextField) {
            
            currencyToConvert = Double(currencyTextField.text!)!
            
            convertedCurrency =  convert(currencyToConvert: currencyToConvert,
                    currencyFrom: currencyToSegmentedIndex)
            reloadView(inputCurrency: currencyToConvert,
                       outputCurrency: convertedCurrency ,
                       currencyFrom: currencyToSegmentedIndex)
            
        } else {
            
            alert(message: "Digit a valid number", title: "Converter error")
        }

        
    }
    
    func validateString (string: UITextField!) -> Bool{
        if (Double(string.text!) != nil) {
            return true
        } else {
            return false
        }
    }
    
    func convert (currencyToConvert : Double,
                  currencyFrom : Int) -> Double {
    
        let convertedCurrency : Double
        if currencyFrom == 0 {
            convertedCurrency = currencyToConvert * dollarToCop
        }else {
            convertedCurrency = currencyToConvert / dollarToCop
        }
        
        return convertedCurrency
    }
    
    func reloadView (inputCurrency : Double,
                     outputCurrency : Double,
                     currencyFrom : Int) {
        
        let initValue = changeFormart(string: String(inputCurrency), currency: currencyFrom)
        let endValue = changeFormart(string: String(outputCurrency), currency: currencyFrom)
        
        if currencyFrom == 0 {
            resultLabel.text = "\(initValue) USD = \(endValue) COP"
        } else {
            resultLabel.text = "\(initValue) COP = \(endValue) USD"
        }
    }
    
    func alert (message : String,
                title : String){
        
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        let okAlert = UIAlertAction(title: "OK",
                                    style: .default,
                                    handler: nil)
        
        alertController.addAction(okAlert)
        
        present(alertController, animated: true, completion: nil)
    }

    func changeFormart (string : String,
                        currency : Int) -> String {
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        if currency == 1 {
            formatter.string(from: NSNumber(value: Double(string)!))
        }else {
            formatter.locale = Locale(identifier: "en_US")
            formatter.string(from: NSNumber(value: Double(string)!))
        }
        return (formatter.string(from: NSNumber(value: Double(string)!)))!
    }
}

