//
//  ViewController.swift
//  Calculator
//
//  Created by Pei Pei on 2021/7/23.
//

import UIKit

class ViewController: UIViewController {

  @IBAction func navigateToCalculatorVC(_ sender: UIButton) {

    performSegue(withIdentifier: "NavigateToCalculatorVC", sender: sender)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }
}

