//
//  CalculatorViewController.swift
//  Calculator
//
//  Created by Pei Pei on 2021/7/23.
//

import UIKit

enum Operation: String {
  case Add = "="
  case Subtract = "-"
  case Divide = "/"
  case Mutiply = "*"
  case Null = "Null"
}

class CalculatorViewController: UIViewController {

  // MARK: - Properties
  var inputNumber = "" // Number display on the screen
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
    // When inputNumber exist and it is Int, we can calculate factorial
    if inputNumber != "" {

      if inputNumber.isInt {

        // TODO: - 檢查負數也要return error

        let factorialResult = getFactorial(num: Int(inputNumber)!)

        if Int(inputNumber)! < 21 {

          inputNumber = String(Int(factorialResult))
          leftValue = inputNumber      // And update for the next calculation
          outputLabel.text = inputNumber
          outputLabel.adjustsFontSizeToFitWidth = true

        } else {
          inputNumber = String(factorialResult)
          leftValue = inputNumber
          outputLabel.text = inputNumber
          outputLabel.adjustsFontSizeToFitWidth = true
        }

      } else {
        inputNumber = ""
        outputLabel.text = "Error"
      }

    // When no inputNumber means only result exist, and if the result is Int, we can calculate factorial
    } else {  // runningNumber == ""

      if result.isInt {

        let factorialResult = getFactorial(num: Int(result)!)

        if Int(result)! < 21 {

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

      } else {
        result = ""
        outputLabel.text = "Error"
      }
    }
  }

  @IBAction func allClearPressed(_ sender: RoundBtn) {
    inputNumber = ""
    leftValue = ""
    rightValue = ""
    currentOperation = .Null
    outputLabel.text = ""
  }

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

        // Convert Result from Double to Int
        if Double(result)!.truncatingRemainder(dividingBy: 1) == 0 {
          result = "\(Int(Double(result)!))"
        }

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
}

extension String {
  var isInt: Bool {
    return Int(self) != nil
  }
}

