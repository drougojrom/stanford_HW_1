//
//  ViewController.swift
//  Calculator
//
//  Created by Roman Ustiantcev on 11/04/16.
//  Copyright © 2016 Roman Ustiantcev. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    @IBOutlet weak var dotButton: UIButton!
    @IBOutlet weak var operationStackHistory: UILabel!

    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTypingANumber = false

    @IBAction func appendDigit(sender: UIButton) {
        
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber{
            display.text = display.text! + digit
        } else {
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
        
        print("digit = \(digit)")
        
    }

    var operandStack = Array<Double>()
    
    @IBAction func operate(sender: UIButton) {
        
        let operation = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        
        switch operation {
        case "✕": performOperation { $0 * $1 }
        case "÷": performOperation { $1 / $0 }
        case "+": performOperation { $0 + $1 }
        case "-": performOperation { $0 - $1 }
        case "√": performOperationOne { sqrt($0) }
        case ".": addDot()
        case "∁": cleanStack()
        case "sin": performOperationOne { sin($0) }
        case "cos": calcCos()
        case "PI": addPI()
            
        default:
            break
            
        }
    }
    
//    func calcSin(){
//        let lastAdded = operandStack.last
//        print(lastAdded)
//        let sinLastAdded = Double(sin(lastAdded!))
//        operandStack.append(sinLastAdded)
//        display.text = "\(sinLastAdded)"
//    }
    
    func calcCos(){
        let lastAdded = operandStack.last
        print(lastAdded)
        let sinLastAdded = Double(cos(lastAdded!))
        operandStack.append(sinLastAdded)
        display.text = "\(sinLastAdded)"
        operationStackHistory.text = "\(operandStack)"
    }
    
    func addPI(){
        let pi = M_PI
        operandStack.append(pi)
        display.text = "\(pi)"
        print(operandStack)
        operationStackHistory.text = "\(operandStack)"
    }
    
    func cleanStack(){
        operandStack = []
        print("operandStack clreaned: \(operandStack)")
        display.text = "0"
        operationStackHistory.text = "No values in stack"
    }
    
    func addDot() {
        var dottedValues = Array<String>()
        dottedValues.append(String(operandStack.last) + ".")
    }
    
    func performOperation(operation: (Double, Double) -> Double) {
        
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
            dotButton.enabled = true
            operationStackHistory.text = "\(operandStack)"
        }
        
    }
    
    func performOperationOne(operation: Double -> Double) {
        
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
            dotButton.enabled = true
            operationStackHistory.text = "\(operandStack)"
        }
        
    }
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        operandStack.append(displayValue)
        print("operandStack = \(operandStack)")
        operationStackHistory.text = "\(operandStack)"
    }
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        
        set {
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
        }
    }
}

