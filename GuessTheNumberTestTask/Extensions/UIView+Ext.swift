//
//  UIView + Ext.swift
//  GuessTheNumberTestTask
//
//  Created by Нагоев Магомед on 26.06.2022.
//

import UIKit

extension UIView {

    func upAnimate() {
        frame.origin.y = -frame.height
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.frame.origin.y = 0
        }
    }
}
