//
//  MainPresenter.swift
//  GuessTheNumberTestTask
//
//  Created by Нагоев Магомед on 24.06.2022.
//

import UIKit

protocol MainPresenterProtocol: class {
    init(view: UIViewController,
         router: RouterProtocol)

    func tapOnNewGameButton()
}

class MainPresenter: MainPresenterProtocol {

    weak private var view: UIViewController?
    private var router: RouterProtocol?

    required init(view: UIViewController,
                  router: RouterProtocol) {
        self.view = view
        self.router = router
    }
    func tapOnNewGameButton() {
        print("pushStartController")
    }
}
