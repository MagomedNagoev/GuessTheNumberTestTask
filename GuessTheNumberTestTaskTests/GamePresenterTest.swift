//
//  GamePresenterTest.swift
//  GuessTheNumberTestTaskTests
//
//  Created by Нагоев Магомед on 26.06.2022.
//

import XCTest
@testable import GuessTheNumberTestTask

class MockGameView: GameViewProtocol {
    func setDataToComputerScreen(attempts: Int, guessNumber: Int) {}

    func setDataToPlayerScreen(attempts: Int, comparisonResult: String) {}

    func setDataToResultScreen(humanTries: Int, computerTries: Int, resultGame: String) {}

    func setupPlayerScreen() {}

    func setupComputerScreen() {}

    func setupResultScreen() {}

    func missClick() {}

}

class GamePresenterTest: XCTestCase {

    var view: MockGameView!
    var presenter: GamePresenter!
    var router: RouterProtocol!
    var playerHuman: PlayerModel!
    var playerComputer: ComputerPlayerModel!

    override func setUp() {
        let navigationController = UINavigationController()
        let builder = Builder()

        view = MockGameView()
        router = Router(navigationController: navigationController,
                        builder: builder)

    }

    override func tearDown() {
        view = nil
        presenter = nil
        router = nil
    }

    func testCompareNumbers() {
        playerHuman = PlayerModel(myNumber: 1)
        playerComputer = ComputerPlayerModel(player: PlayerModel(myNumber: 2),
                                             minGuessingNumber: 1,
                                             maxGuessingNumber: 100)

        presenter = GamePresenter(view: view,
                                  router: router,
                                  playerHuman: playerHuman,
                                  playerComputer: playerComputer)

        presenter.compareNumbers(playerGuessNumber: 1)

        XCTAssertTrue(presenter.playerHuman.attemptsToGuess == 2)

        presenter.compareNumbers(playerGuessNumber: 3)

        XCTAssertEqual(presenter.playerHuman.attemptsToGuess, 3)

        presenter.compareNumbers(playerGuessNumber: 2)

        XCTAssertEqual(presenter.playerHuman.attemptsToGuess, 3)
        XCTAssertEqual(presenter.screenType, GamePresenter.ScreenType.result)
    }

    func testMoreNumber() {
        playerHuman = PlayerModel(myNumber: 100)
        playerComputer = ComputerPlayerModel(player: PlayerModel(myNumber: 2),
                                             minGuessingNumber: 0,
                                             maxGuessingNumber: 100)

        presenter = GamePresenter(view: view,
                                  router: router,
                                  playerHuman: playerHuman,
                                  playerComputer: playerComputer)

        presenter.moreNumber()

        XCTAssertTrue(presenter.playerComputer.player.attemptsToGuess > 1)
        XCTAssertEqual(presenter.playerComputer.minGuessingNumber, 50)
    }

    func testLessNumber() {
        playerHuman = PlayerModel(myNumber: 1)
        playerComputer = ComputerPlayerModel(player: PlayerModel(myNumber: 2),
                                             minGuessingNumber: 0,
                                             maxGuessingNumber: 100)

        presenter = GamePresenter(view: view,
                                  router: router,
                                  playerHuman: playerHuman,
                                  playerComputer: playerComputer)

        presenter.lessNumber()

        XCTAssertTrue(presenter.playerComputer.player.attemptsToGuess > 1)
        XCTAssertEqual(presenter.playerComputer.maxGuessingNumber, 50)
    }

    func testEquelNumber() {
        playerHuman = PlayerModel(myNumber: 12)
        playerComputer = ComputerPlayerModel(player: PlayerModel(myNumber: 2),
                                             minGuessingNumber: 6,
                                             maxGuessingNumber: 18)

        presenter = GamePresenter(view: view,
                                  router: router,
                                  playerHuman: playerHuman,
                                  playerComputer: playerComputer)

        presenter.equalNumber()

        XCTAssertEqual(presenter.screenType, GamePresenter.ScreenType.player)
    }

    func testTapOnMainMenu() {
        playerHuman = PlayerModel(myNumber: 12)
        playerComputer = ComputerPlayerModel(player: PlayerModel(myNumber: 2),
                                             minGuessingNumber: 6,
                                             maxGuessingNumber: 18)

        presenter = GamePresenter(view: view,
                                  router: router,
                                  playerHuman: playerHuman,
                                  playerComputer: playerComputer)

        XCTAssertEqual(router.navigationController?.viewControllers.count, 0)

        presenter.tapOnMainMenu()

        XCTAssertEqual(router.navigationController?.viewControllers.count, 1)
    }
}
