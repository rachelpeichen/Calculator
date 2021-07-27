//
//  CalculatorViewController.swift
//  Calculator
//
//  Created by Pei Pei on 2021/7/23.
//

import UIKit

enum Operation {
  case Add
  case Subtract
  case Divide
  case Mutiply
  case Null
}

class CalculatorViewController: UIViewController {

  // MARK: - Properties
  var inputNumber = ""
  var leftValue = ""
  var rightValue = ""
  var result = ""
  var currentOperation: Operation = .Null

  // MARK: - IBOutlets
  @IBOutlet weak var outputLabel: UILabel!
  @IBOutlet weak var dotBtn: RoundBtn!

  // MARK: - IBActions
  @IBAction func zeroPressed(_ sender: RoundBtn) {
    // First number cannot be 0
    if inputNumber != "0" {
      inputNumber += "\(sender.tag)"
      outputLabel.text = inputNumber
    }
  }

  @IBAction func numberPressed(_ sender: RoundBtn) {
    // If first number is 0, replace it
    if inputNumber == "0" {
      inputNumber = "\(sender.tag)"
      outputLabel.text = inputNumber

    } else {
      if inputNumber.count <= 8 {
        inputNumber += "\(sender.tag)"
        outputLabel.text = inputNumber
      }
    }
  }

  @IBAction func dotPressed(_ sender: RoundBtn) {

    if inputNumber.contains(".") {
      print("Can't add any dot!")

    } else if inputNumber.count <= 7 {
      inputNumber += "."
      outputLabel.text = inputNumber
    }
  }

  @IBAction func equalPressed(_ sender: RoundBtn) {
    operation(operation: currentOperation)
  }

  @IBAction func addPressed(_ sender: RoundBtn) {
    operation(operation: .Add)
  }

  @IBAction func subtractPressed(_ sender: RoundBtn) {
    operation(operation: .Subtract)
  }

  @IBAction func multiplyPressed(_ sender: RoundBtn) {
    operation(operation: .Mutiply)
  }

  @IBAction func dividePressed(_ sender: RoundBtn) {
    operation(operation: .Divide)
  }

  @IBAction func factorialPressed(_ sender: RoundBtn) {
    operateFactorial()
  }

  @IBAction func allClearPressed(_ sender: RoundBtn) {
    inputNumber = ""
    leftValue = ""
    rightValue = ""
    currentOperation = .Null
    outputLabel.text = ""
  }

  // MARK: View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
    outputLabel.text = ""
  }

  // MARK: Functions
  func operation(operation: Operation) {

    if currentOperation != .Null {
      if inputNumber != "" {

        rightValue = inputNumber
        inputNumber = ""

        switch currentOperation {
        case .Add:
          result = "\(Double(leftValue)! + Double(rightValue)!)"
        case .Subtract:
          result = "\(Double(leftValue)! - Double(rightValue)!)"
        case .Mutiply:
          result = "\(Double(leftValue)! * Double(rightValue)!)"
        case .Divide:
          result = "\(Double(leftValue)! / Double(rightValue)!)"
        default:
          print("Nothing")
        }

        let doubleResult = result.toDouble
        result = doubleResult.convertToStr(result: doubleResult)

        leftValue = result
        
        outputLabel.text = result
        outputLabel.adjustsFontSizeToFitWidth = true
      }
      currentOperation = operation

    } else {
      leftValue = inputNumber
      inputNumber = ""
      currentOperation = operation
    }
  }

  func getFactorial(num: Int) -> Double {
    if num == 0 {
      return 1
    }
    return Double(num) * getFactorial(num: num - 1)
  }

  func operateFactorial() {
    // When inputNumber exist and it is Int(>0), we can calculate factorial
    if inputNumber != "" {

      if inputNumber.isInt {

        let factorialResult = getFactorial(num: inputNumber.toInt)

        if inputNumber.toInt < 21 {
          inputNumber = String(factorialResult.toInt)
          leftValue = inputNumber       // Update for the next calculation
          outputLabel.text = inputNumber
          outputLabel.adjustsFontSizeToFitWidth = true

        } else { // 21! > 64 bit integer max value so use double
          inputNumber = String(factorialResult)
          leftValue = inputNumber
          outputLabel.text = inputNumber
          outputLabel.adjustsFontSizeToFitWidth = true
        }

      } else {  // non-Int can't calculate factorial
        inputNumber = ""
        outputLabel.text = "Error"
      }

    } else {  // inputNumber == ""
      // When no inputNumber means only result exist, and if the result is Int(>0), we can calculate factorial
      if result.isInt {

        if result.toInt < 0 {
          inputNumber = ""
          outputLabel.text = "Error"

        } else {
          let factorialResult = getFactorial(num: result.toInt)

          if result.toInt < 21 {
            result = String(Int(factorialResult))
            leftValue = result
            outputLabel.text = result
            outputLabel.adjustsFontSizeToFitWidth = true

          } else {
            result = String(factorialResult)
            leftValue = result
            outputLabel.text = result
            outputLabel.adjustsFontSizeToFitWidth = true
          }
        }

      } else {
        result = ""
        outputLabel.text = "Error"
      }
    }
  }
}


