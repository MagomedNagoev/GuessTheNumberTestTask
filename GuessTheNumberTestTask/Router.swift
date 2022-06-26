//
//  Router.swift
//  GuessTheNumberTestTask
//
//  Created by Нагоев Магомед on 24.06.2022.
//

import UIKit

protocol RouterMain {
    var navigationController: UINavigationController? { get set }
    var builder: BuilderProtocol? { get set }
}

protocol RouterProtocol: RouterMain {
    func initialViewController()
    func showGameViewController(playerHuman: PlayerModel,
                                playerComputer: ComputerPlayerModel)
}

class Router: RouterProtocol {

    // MARK: - Properties
    var navigationController: UINavigationController?
    var builder: BuilderProtocol?

    // MARK: - Initializers
    init(navigationController: UINavigationController,
         builder: BuilderProtocol) {
        self.navigationController = navigationController
        self.builder = builder
        navigationController.view.backgroundColor = .white
        setupNavigationController()
    }

    // MARK: - Methods
    private func setupNavigationController() {
        navigationController?.navigationBar.isHidden = true
    }

    func initialViewController() {
        if let navigationController = navigationController {
            guard let mainViewController = builder?.createMainModule(router: self) else { return }
            navigationController.viewControllers = [mainViewController]
        }
    }

    func showGameViewController(playerHuman: PlayerModel,
                                playerComputer: ComputerPlayerModel) {
        guard let gameViewController =
                builder?.createGameModule(router: self,
                                          playerHuman: playerHuman,
                                          playerComputer: playerComputer) else { return }

        if let navigationController = navigationController {
            navigationController.pushViewController(gameViewController, animated: true)
        }
    }
}
