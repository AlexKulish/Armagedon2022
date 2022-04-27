//
//  UILabel.swift
//  Armagedon2022
//
//  Created by Alex Kulish on 26.04.2022.
//

import UIKit

extension UILabel {
    
    func changeIfNeedRangeColor(fullText: String, changeText: String) {
        let attributedString: NSString = fullText as NSString
        let range = attributedString.range(of: changeText)
        let attribute = NSMutableAttributedString(string: fullText)
        attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: range)
        self.attributedText = attribute
    }
    
}
