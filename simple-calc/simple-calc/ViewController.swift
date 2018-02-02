//
//  ViewController.swift
//  simple-calc
//
//  Created by Andre Nguyen on 1/28/18.
//  Copyright © 2018 Andre Nguyen. All rights reserved.
//

import UIKit

enum Operation:String {
    case Add = "+"
    case Subtract = "-"
    case Divide = "/"
    case Multiply = "*"
    case Mod = "%"
    case NULL = "Null"
}

enum SpecialOperation:String {
    case Count
    case Avg
    case Fact
    case NULL = "Null"
}

class ViewController: UIViewController {
    
    var wordBank:[String] = ["hello"]
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is ViewController2 {
            let talkView = segue.destination as? ViewController2
            talkView?.wordBank = wordBank
        }
    }
    

    @IBOutlet weak var outputLabel: UILabel!
    
    var runningNumber = ""
    var leftValue = ""
    var rightValue = ""
    var result = ""
    var currentOperation:Operation = .NULL
    var currentSpecialOperation:SpecialOperation = .NULL
    var count = 0
    var sum = 0.0
    var sumCount = 0
    var historyAvg = ""
    var historyCount = ""
    var historyBasic = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        outputLabel.text = "0"
    }


    @IBAction func numberPressed(_ sender: RoundButton) {
        if runningNumber.count <= 8 {
            runningNumber += "\(sender.tag)"
            outputLabel.text = runningNumber
            historyBasic += "\(runningNumber)"
        }
    }
    
    @IBAction func allClearPressed(_ sender: RoundButton) {
        runningNumber = ""
        leftValue = ""
        rightValue = ""
        result = ""
        currentOperation = .NULL
        outputLabel.text = "0"
        currentSpecialOperation = .NULL
        count = 0
        sum = 0
        sumCount = 0
        historyAvg = ""
        historyCount = ""
        historyBasic = ""
    }
    
    @IBAction func dotPressed(_ sender: RoundButton) {
        if runningNumber.count <= 7 {
            runningNumber += "."
            outputLabel.text = runningNumber
            historyBasic += "\(runningNumber)"
        }
        
    }
    
    @IBAction func equalPressed(_ sender: RoundButton) {
        if currentSpecialOperation == .Count || currentSpecialOperation == .Avg || currentSpecialOperation == .Fact {
            if (currentSpecialOperation == .Avg) {
                historyAvg += "\(runningNumber)"
                sum += Double(runningNumber)!
            }
            if (currentSpecialOperation == .Count) {
                historyCount += "\(runningNumber)"
            }
            runningNumber = ""
            specialOperation(specialOperation: currentSpecialOperation)
        } else {
            operation(operation: currentOperation)
        }
    }
    
    @IBAction func addPressed(_ sender: RoundButton) {
        historyBasic += " + "
        operation(operation: .Add)
    }
    
    @IBAction func subtractPressed(_ sender: RoundButton) {
        historyBasic += " - "
        operation(operation: .Subtract)
    }
    
    @IBAction func multiplyPressed(_ sender: RoundButton) {
        historyBasic += " * "
        operation(operation: .Multiply)
    }
    
    @IBAction func dividePressed(_ sender: RoundButton) {
        historyBasic += " / "
        operation(operation: .Divide)
    }

    @IBAction func modPressed(_ sender: RoundButton) {
        historyBasic += " % "
        operation(operation: .Mod)
    }
    
    @IBAction func factorialPressed(_ sender: RoundButton) {
        currentSpecialOperation = .Fact
        specialOperation(specialOperation: .Fact)
    }
    
    @IBAction func countPressed(_ sender: RoundButton) {
        currentSpecialOperation = .Count
        specialOperation(specialOperation: .Count)
    }
    
    @IBAction func averagePressed(_ sender: RoundButton) {
        currentSpecialOperation = .Avg
        specialOperation(specialOperation: .Avg)
    }
    
    
    // wordBank.append(..text...)
    func operation(operation: Operation) {
        if currentOperation != .NULL {
            if runningNumber != "" {
                rightValue = runningNumber
                runningNumber = ""
                
                switch currentOperation {
                case .Add:
                    result = "\(Double(leftValue)! + Double(rightValue)!)"
                case .Subtract:
                    result = "\(Double(leftValue)! - Double(rightValue)!)"
                case .Multiply:
                    result = "\(Double(leftValue)! * Double(rightValue)!)"
                case .Divide:
                    result = "\(Double(leftValue)! / Double(rightValue)!)"
                case .Mod:
                    let times = Int(leftValue)! / Int(rightValue)!
                    result = "\(Int(leftValue)! - (times * Int(rightValue)!))"
                default:
                    result = ""
                }
                leftValue = result
                if (Double(result)!.truncatingRemainder(dividingBy: 1) == 0) {
                    result = "\(Int(Double(result)!))"
                }
                wordBank.append("\(historyBasic) = \(result)")
                historyBasic = ""
                outputLabel.text = result
                rightValue = ""
                currentOperation = .NULL
            } else {
                currentOperation = operation
            }
        } else if(runningNumber == "" && leftValue != ""){
            currentOperation = operation

        } else {
            leftValue = runningNumber
            runningNumber = ""
            currentOperation = operation
        }

    }
    
    func specialOperation(specialOperation: SpecialOperation) {

        if specialOperation == .Count {
            if runningNumber == "" {
                result = "\(count + 1)"
                outputLabel.text = result
                wordBank.append("\(historyCount) = \(result)")
                count = 0
                runningNumber = ""
                historyCount = ""
                currentSpecialOperation = .NULL
            } else {
                historyCount += "\(runningNumber) count "
                count += 1
                runningNumber = ""
            }
        } else if specialOperation == .Fact {
            if Int(runningNumber) == 0 {
                result = "1"
                outputLabel.text = result
                runningNumber = ""
                currentSpecialOperation = .NULL
            } else {
                var answer = 1
                for number in 1...Int(runningNumber)! {
                    answer *= number
                }
                result = "\(answer)"
                outputLabel.text = result
                wordBank.append("\(runningNumber)! = \(result)")
                historyBasic = ""
                runningNumber = ""
                currentSpecialOperation = .NULL
            }
            
        } else if specialOperation == .Avg {
            if runningNumber == "" {
           
                result = "\(sum / Double(sumCount + 1))"
                if (Double(result)!.truncatingRemainder(dividingBy: 1) == 0) {
                    result = "\(Int(Double(result)!))"
                }
                outputLabel.text = result
                wordBank.append("\(historyAvg) = \(result)")
                historyAvg = ""
                runningNumber = ""
                sum = 0
                sumCount = 0
                currentSpecialOperation = .NULL
            } else {
                sum += Double(runningNumber)!
                sumCount += 1
                historyAvg += "\(runningNumber) avg "
                runningNumber = ""
            }
        }
    }
    
}

