//
//  NumberTextField.swift
//  GuessTheNumberTestTask
//
//  Created by Нагоев Магомед on 24.06.2022.
//

import UIKit

final class NumberTextField: UITextField, UITextFieldDelegate {

    override init(frame: CGRect) {
        super.init(frame: frame)
        delegate = self
        setupTextField()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {

        let stringNumber = NSString(string: textField.text ?? "0")
            .replacingCharacters(in: range, with: string)

        if let number = Int(stringNumber),
           number >= 1 && number <= 100 {
            return true
        }

        if stringNumber.isEmpty {
            return true
        }

        return false
    }

    private func setupTextField() {
        self.isHidden = true
        layer.cornerRadius = 10
        layer.borderColor = UIColor.lightGray.cgColor
        backgroundColor = .white
        borderStyle = .roundedRect
        returnKeyType = .done
        textAlignment = .center
        placeholder = "Guess the number"
        keyboardType = .numberPad
        translatesAutoresizingMaskIntoConstraints = false
    }
}
