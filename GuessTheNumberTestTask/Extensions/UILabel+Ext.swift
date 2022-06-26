//
//  UILabel+Ext.swift
//  GuessTheNumberTestTask
//
//  Created by Нагоев Магомед on 24.06.2022.
//

import UIKit

extension UILabel {

    convenience init(text: String = "", textAlignment: NSTextAlignment) {
        self.init(frame: .zero)
        self.text = text
        self.font = UIFont.systemFont(ofSize: 16)
        self.textColor = .black
        self.textAlignment = textAlignment
        self.translatesAutoresizingMaskIntoConstraints = false
        self.isHidden = true
    }
}
