//
//  Palette.swift
//  Navigation
//
//  Created by Alex M on 30.11.2022.
//

import UIKit
struct Palette {

    static func createColor(lightMode: UIColor, darkMode: UIColor) -> UIColor {
        guard #available(iOS 13.0, *) else {
            return lightMode
        }
        return UIColor { (traitCollection) -> UIColor in
            return traitCollection.userInterfaceStyle == .light ? lightMode : darkMode
        }
    }

}


extension UIColor {
    static var buttonBackgroundColor: UIColor = {
        if #available(iOS 13, *) {
            return UIColor { (traitCollection: UITraitCollection) -> UIColor in
                if traitCollection.userInterfaceStyle == .dark {
                    return UIColor(red: 0.678, green: 0.239, blue: 0.643, alpha: 1.0) // Темный цвет из палитры
                } else {
                    return UIColor(red: 0.318, green: 0.506, blue: 0.722, alpha: 1.0)// Светлый цвет из палитры
                }
            }
        } else {
            return UIColor.systemBlue // Цвет по умолчанию
        }
    }()


    static var tintColor: UIColor = {
        if #available(iOS 13, *) {
            return UIColor { (traitCollection: UITraitCollection) -> UIColor in
                if traitCollection.userInterfaceStyle == .dark {
                    return UIColor(red: 0.039, green: 0.518, blue: 1.0, alpha: 1.0) // Темный цвет из палитры
                } else {
                    return UIColor(red: 0.149, green: 0.149, blue: 0.149, alpha: 1.0)// Светлый цвет из палитры
                }
            }
        } else {
            return UIColor.systemBlue // Цвет по умолчанию
        }
    }()

}
