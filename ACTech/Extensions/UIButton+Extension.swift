//
//  UIButton+Extension.swift
//  ACTech
//
//  Created by mac on 9/16/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    func underline(text: String) {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 15),
            .foregroundColor: UIColor.blue,
            .underlineStyle: NSUnderlineStyle.single.rawValue]
        
        let attributeString = NSMutableAttributedString(string: self.titleLabel?.text ?? "", attributes: nil)
        let attributeRange = (attributeString.string as NSString).range(of: text)
        attributeString.addAttributes(attributes, range: attributeRange)
        self.setAttributedTitle(attributeString, for: .normal)
        
    }
    
}
