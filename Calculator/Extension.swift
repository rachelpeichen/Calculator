//
//  Extension.swift
//  Calculator
//
//  Created by Pei Pei on 2021/7/27.
//

import Foundation

extension String {

  var isInt: Bool {
    return Int(self) != nil
  }

  var toInt: Int {
    return Int(self) ?? 0
  }

  var toDouble: Double {
    return Double(self) ?? 0.0
  }


}

extension Double {

  var toInt: Int {
    return Int(self) 
  }

  // Formatting result value
  func convertToStr(result: Double) ->String {

    if result.truncatingRemainder(dividingBy: 1) == 0 {
      return String(Int(result))

    } else {
      return String(result)
    }
  }
}
