//
//  Builder.swift
//  GuessTheNumberTestTask
//
//  Created by Нагоев Магомед on 24.06.2022.
//

import UIKit

protocol BuilderProtocol {
    func createMainModule(router: RouterProtocol) -> UIViewController
}

class Builder: BuilderProtocol {
    func createMainModule(router: RouterProtocol) -> UIViewController {
        let view = MainViewController()
        let presenter = MainPresenter(view: view,
                                      router: router)
        view.presenter = presenter
        return view
    }
}
