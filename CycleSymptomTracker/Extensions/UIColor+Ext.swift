//
//  UIColor+Ext.swift
//  Cycle Symptom Tracker
//
//  Created by Bianca Curutan on 10/31/21.
//

import UIKit

// https://venngage.com/blog/blue-color-palettes/
// Burnt Sienna Orange + Bedazzled Blue Color Palette
extension UIColor {
    static var backgroundColor: UIColor {
        return UIColor(rgb: 0xfafafa) // very light gray
    }

    static var borderColor: UIColor {
        return UIColor(rgb: 0xdcdcdc) // light gray
    }

    static var accentColor: UIColor {
        return UIColor(red: 99/255, green: 43/255, blue: 108/255, alpha: 1.0) // #632b6c purple // TODO
    }

    static var headerTextColor: UIColor {
        return UIColor(rgb: 0x3d5a80) // dark slate
    }

    static var primaryTextColor: UIColor {
        return UIColor(rgb: 0x293241) // dark black-blue
    }

    static var secondaryTextColor: UIColor {
        return UIColor.lightGray
    }

    static var primaryButtonColor: UIColor {
        return UIColor(rgb: 0xee6c4d) // orange
    }

    static var primaryHighlightedButtonColor: UIColor {
        return UIColor(rgb: 0xee6c4d).withAlphaComponent(0.5) // orange with alpha
    }

    static var highlightColor: UIColor {
        return UIColor(rgb: 0xe0fbfc) // light blue
    }

    // Usage: UIColor(red: 0xFF, green: 0xFF, blue: 0xFF)
    convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

        self.init(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: 1.0)
    }

    // Usage: UIColor(rgb: 0xFFFFFF)
    convenience init(rgb: Int) {
        self.init(red: (rgb >> 16) & 0xFF, green: (rgb >> 8) & 0xFF,blue: rgb & 0xFF)
    }
}

