//
//  Extensions.swift
//  DraftHQ2021
//
//  Created by Taylor Pubins on 5/12/20.
//  Copyright © 2020 trpubz. All rights reserved.
//

import Foundation
import SwiftUI

extension CGFloat {
    func map(from: ClosedRange<CGFloat>, to: ClosedRange<CGFloat>) -> CGFloat {
        let result = ((self - from.lowerBound) / (from.upperBound - from.lowerBound)) * (to.upperBound - to.lowerBound) + to.lowerBound
        return result
    }
}

extension NumberFormatter {
    static var shekels: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.alwaysShowsDecimalSeparator = false
        formatter.currencySymbol = "₪ "
//        formatter.locale = NSLocale.init(localeIdentifier: "he_IL") as Locale
        formatter.numberStyle = .none
        
        return formatter
    }
}

// MARK: - converts an int to a string with no wrapper
extension Int {
    var string: String {
        return String(self)
    }
}
extension Double {
    var clean: String {
       return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
// MARK: - shorthand references for common mapping tasks
extension Collection where Element: Numeric {
    /// Returns the total sum of all elements in the array
    var total: Element { reduce(0, +) }
}

extension Collection where Element: BinaryInteger {
    /// Returns the average of all elements in the array
    var average: Double { isEmpty ? 0 : Double(total) / Double(count) }
}

extension Collection where Element: BinaryFloatingPoint {
    /// Returns the average of all elements in the array
    var average: Element { isEmpty ? 0 : total / Element(count) }
}

// MARK: - quick color ref
extension Color {
    public static let myPri = Color("myPri")
    public static let altRed = Color("accent1")
    public static let altWhite = Color("accent2")
}
