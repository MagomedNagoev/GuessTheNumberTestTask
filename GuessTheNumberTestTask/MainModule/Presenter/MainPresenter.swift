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
    func setPlayerHumanNumber(playerNumber: Int)
}

class MainPresenter: MainPresenterProtocol {

    // MARK: - Private properties
    private var playerHuman: PlayerModel?
    private var playerComputer: ComputerPlayerModel?
    weak private var view: UIViewController?
    private var router: RouterProtocol?

    // MARK: - Initializers
    required init(view: UIViewController,
                  router: RouterProtocol) {
        self.view = view
        self.router = router
        playerComputer = ComputerPlayerModel(player: PlayerModel(myNumber: Int.random(in: 1...100)))
    }

    // MARK: - Methods
    func tapOnEnterTheNumber() {
        guard let playerHuman = playerHuman,
              let playerComputer = playerComputer else { return }

        router?.showGameViewController(playerHuman: playerHuman,
                                       playerComputer: playerComputer)
        print("Debug:",playerComputer.player.myNumber)

    }

    func setPlayerHumanNumber(playerNumber: Int) {
        playerHuman = PlayerModel(myNumber: playerNumber)
    }

}
