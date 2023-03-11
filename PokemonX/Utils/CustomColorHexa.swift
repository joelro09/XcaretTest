//
//  CustomColorHexa.swift
//  PokemonX
//
//  Created by Joel Ramirez on 07/03/23.
//
import UIKit

extension UIColor {
    convenience init?(hexString: String) {
            var hexString = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
            hexString = hexString.replacingOccurrences(of: "#", with: "")

            var rgbValue: UInt64 = 0
            Scanner(string: hexString).scanHexInt64(&rgbValue)

            let r = (rgbValue & 0xFF0000) >> 16
            let g = (rgbValue & 0x00FF00) >> 8
            let b = rgbValue & 0x0000FF

            self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: 1.0)
        }
}
