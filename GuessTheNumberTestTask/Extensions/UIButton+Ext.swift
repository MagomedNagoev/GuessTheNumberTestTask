//
//  UIButton+Ext.swift
//  GuessTheNumberTestTask
//
//  Created by Нагоев Магомед on 24.06.2022.
//

import UIKit

extension UIButton {
    func blueButton(buttonName: String) {
        self.backgroundColor = .systemBlue
        self.setTitle(buttonName, for: .normal)
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        self.titleLabel?.numberOfLines = 1
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 10
    }

    func comparisonButton(buttonName: String) {
        self.backgroundColor = .white
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
        self.setTitleColor(.black, for: .normal)
        self.setTitle(buttonName, for: .normal)
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        self.titleLabel?.numberOfLines = 1
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 10
    }
}
