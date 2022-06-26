//
//  Builder.swift
//  GuessTheNumberTestTask
//
//  Created by Нагоев Магомед on 24.06.2022.
//

import UIKit

protocol BuilderProtocol {
    func createMainModule(router: RouterProtocol) -> UIViewController
    func createGameModule(router: RouterProtocol,
                          playerHuman: PlayerModel,
                          playerComputer: ComputerPlayerModel) -> UIViewController
}

class Builder: BuilderProtocol {
    
    // MARK: - Methods
    func createMainModule(router: RouterProtocol) -> UIViewController {
        let view = MainViewController()
        let presenter = MainPresenter(view: view,
                                      router: router)
        view.presenter = presenter
        return view
    }

    func createGameModule(router: RouterProtocol,
                          playerHuman: PlayerModel,
                          playerComputer: ComputerPlayerModel) -> UIViewController {
        let view = GameViewController()
        let presenter = GamePresenter(view: view,
                                      router: router,
                                      playerHuman: playerHuman,
                                      playerComputer: playerComputer)
        view.presenter = presenter
        return view
    }
}
