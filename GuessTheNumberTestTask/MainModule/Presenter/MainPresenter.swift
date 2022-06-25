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

    func tapOnEnterTheNumber()
}

class MainPresenter: MainPresenterProtocol {

    private var playerHuman: PlayerModel?
    private var playerComputer: PlayerModel?
    weak private var view: UIViewController?
    private var router: RouterProtocol?

    required init(view: UIViewController,
                  router: RouterProtocol) {
        self.view = view
        self.router = router
        playerComputer?.myNumber = Int.random(in: 1...100)
    }

    func tapOnEnterTheNumber() {
        print("tapOnEnterTheNumber")
    }

    func setPlayerHumanNumber(playerNumber: Int) {
        playerHuman?.myNumber = playerNumber
    }

}
