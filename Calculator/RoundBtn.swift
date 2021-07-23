//
//  RoundBtn.swift
//  Calculator
//
//  Created by Pei Pei on 2021/7/23.
//

import UIKit

@IBDesignable
class RoundBtn: UIButton {

  @IBInspectable var roundBtn: Bool = true {

    didSet {
      if roundBtn {
        layer.cornerRadius = frame.height / 2
      }
    }
  }
}
