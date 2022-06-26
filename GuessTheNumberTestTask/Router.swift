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
    func popToRootViewController()
}

protocol RouterProtocol: RouterMain {
    func initialViewController()
    func showGameViewController(playerHuman: PlayerModel,
                                playerComputer: PlayerModel)
}

class Router: RouterProtocol {
    var navigationController: UINavigationController?
    var builder: BuilderProtocol?

    init(navigationController: UINavigationController,
         builder: BuilderProtocol) {
        self.navigationController = navigationController
        self.builder = builder

        setupNavigationController()
    }

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
                                playerComputer: PlayerModel) {
        guard let gameViewController =
                builder?.createGameModule(router: self,
                                          playerHuman: playerHuman,
                                          playerComputer: playerComputer) else { return }

        if let navigationController = navigationController {
            navigationController.pushViewController(gameViewController, animated: true)
        }
    }

    func popToRootViewController() {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
}
