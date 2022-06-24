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
}
