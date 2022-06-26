//
//  GamePresenter.swift
//  GuessTheNumberTestTask
//
//  Created by Нагоев Магомед on 24.06.2022.
//

import UIKit

protocol GamePresenterProtocol: class {
    init(view: UIViewController,
         router: RouterProtocol,
         playerHuman: PlayerModel,
         playerComputer: PlayerModel)

    func tapOnMainMenu()
}

class GamePresenter: GamePresenterProtocol {

    enum ScreenType {
        case player
        case computer
        case result
    }

    private var playerHuman: PlayerModel
    private var playerComputer: PlayerModel
    weak private var view: UIViewController?
    private var router: RouterProtocol?
    var screenType: ScreenType = .computer

    required init(view: UIViewController,
                  router: RouterProtocol,
                  playerHuman: PlayerModel,
                  playerComputer: PlayerModel) {
        self.view = view
        self.router = router
        self.playerHuman = playerHuman
        self.playerComputer = playerComputer
    }

    func tapOnMainMenu() {
        router?.initialViewController()
    }

}
