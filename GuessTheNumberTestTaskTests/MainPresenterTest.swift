//
//  GuessTheNumberTestTaskTests.swift
//  GuessTheNumberTestTaskTests
//
//  Created by Нагоев Магомед on 24.06.2022.
//

import XCTest
@testable import GuessTheNumberTestTask

class MockView: UIViewController {

}

class MockRouter: RouterProtocol {
    var navigationController: UINavigationController?
    var builder: BuilderProtocol?
    var pushedViewController: UIViewController?

    init(navigationController: UINavigationController,
         builder: BuilderProtocol) {
        self.navigationController = navigationController
        self.builder = builder
        navigationController.view.backgroundColor = .white
    }

    func initialViewController() {
    }

    func showGameViewController(playerHuman: PlayerModel, playerComputer: ComputerPlayerModel) {
        guard let gameViewController =
                builder?.createGameModule(router: self,
                                          playerHuman: playerHuman,
                                          playerComputer: playerComputer) else { return }
        pushedViewController = gameViewController
        if let navigationController = navigationController {
            navigationController.pushViewController(gameViewController, animated: true)
        }
    }
}

class MainPresenterTest: XCTestCase {
    var view: MockView!
    var presenter: MainPresenter!
    var router: MockRouter!

    override func setUp() {
        let navigationController = UINavigationController()
        let builder = Builder()
        view = MockView()
        router = MockRouter(navigationController: navigationController,
                            builder: builder)
        presenter = MainPresenter(view: view,
                                  router: router)

    }

    override func tearDown() {
        view = nil
        presenter = nil
        router = nil
    }

    func testSetPlayerHumanNumber() {
        let myNumber = 1
        presenter.setPlayerHumanNumber(playerNumber: myNumber)

        XCTAssertEqual(myNumber, presenter.playerHuman?.myNumber)
    }

    func testTapOnEnterTheNumber() {
        presenter.setPlayerHumanNumber(playerNumber: 2)
        XCTAssertFalse(router.pushedViewController is GameViewController)

        presenter.tapOnEnterTheNumber()

        XCTAssertTrue(router.pushedViewController is GameViewController)

    }

}
