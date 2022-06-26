//
//  GamePresenter.swift
//  GuessTheNumberTestTask
//
//  Created by Нагоев Магомед on 24.06.2022.
//

import UIKit

protocol GameViewProtocol: class {
    func setDataToComputerScreen(attempts: Int,
                                 guessNumber: Int)
    func setDataToPlayerScreen(attempts: Int,
                               comparisonResult: String)
    func setDataToResultScreen(humanTries: Int,
                               computerTries: Int,
                               resultGame: String)
    func setupPlayerScreen()
    func setupComputerScreen()
    func setupResultScreen()
    func missClick()
}

protocol GamePresenterProtocol: class {
    init(view: GameViewProtocol,
         router: RouterProtocol,
         playerHuman: PlayerModel,
         playerComputer: ComputerPlayerModel)

    func tapOnMainMenu()
    func moreNumber()
    func lessNumber()
    func equalNumber()
    func compareNumbers(playerGuessNumber: Int)
}

class GamePresenter: GamePresenterProtocol {

    enum ScreenType {
        case player
        case computer
        case result
    }

    // MARK: - Private properties
    private var playerHuman: PlayerModel
    private var playerComputer: ComputerPlayerModel
    weak private var view: GameViewProtocol?
    private var router: RouterProtocol?
    private (set) var screenType: ScreenType = ScreenType.computer

    // MARK: - Initializers
    required init(view: GameViewProtocol,
                  router: RouterProtocol,
                  playerHuman: PlayerModel,
                  playerComputer: ComputerPlayerModel) {
        self.view = view
        self.router = router
        self.playerHuman = playerHuman
        self.playerComputer = playerComputer
        initialDataForPlayers()
    }

    // MARK: - Methods
    func initialDataForPlayers() {
        switch screenType {

        case .player:
            view?.setDataToPlayerScreen(
                attempts: playerHuman.attemptsToGuess,
                comparisonResult: "")
            view?.setupPlayerScreen()
        case .computer:
            view?.setDataToComputerScreen(
                attempts: playerComputer.player.attemptsToGuess,
                guessNumber: computerGuessesNumber())
            view?.setupComputerScreen()
        case .result:
            view?.setDataToResultScreen(
                humanTries: playerHuman.attemptsToGuess,
                computerTries: playerComputer.player.attemptsToGuess,
                resultGame: whoWin())
            view?.setupResultScreen()
        }

    }

    func tapOnMainMenu() {
        router?.initialViewController()
    }

    private func computerGuessesNumber() -> Int {
        let guessingNumber = Double(playerComputer.minGuessingNumber + playerComputer.maxGuessingNumber) / 2.0
        return Int(round(guessingNumber))
    }

    func moreNumber() {
        let guessingNumber = computerGuessesNumber()
        guard playerHuman.myNumber > guessingNumber else {
            view?.missClick()
            return
        }

        playerComputer.player.attemptsToGuess += 1
        playerComputer.minGuessingNumber = guessingNumber
        view?.setDataToComputerScreen(
            attempts: playerComputer.player.attemptsToGuess,
            guessNumber: computerGuessesNumber())
    }

    func lessNumber() {
        let guessingNumber = computerGuessesNumber()
        guard playerHuman.myNumber < guessingNumber else {
            view?.missClick()
            return
        }

        playerComputer.player.attemptsToGuess += 1
        playerComputer.maxGuessingNumber = guessingNumber
        view?.setDataToComputerScreen(
            attempts: playerComputer.player.attemptsToGuess,
            guessNumber: computerGuessesNumber())
    }

    func equalNumber() {
        let guessingNumber = computerGuessesNumber()
        guard playerHuman.myNumber == guessingNumber else {
            view?.missClick()
            return
        }

        changeScreenType(screenType: .player)
    }

    func compareNumbers(playerGuessNumber: Int) {
        var result = ""

        switch true {
        case playerComputer.player.myNumber > playerGuessNumber:
            result = ComparisonOperator.more.rawValue
        case playerComputer.player.myNumber < playerGuessNumber:
            result = ComparisonOperator.less.rawValue
        case playerComputer.player.myNumber == playerGuessNumber:
            changeScreenType(screenType: .result)
        default: break
        }

        if screenType != .result {
            playerHuman.attemptsToGuess += 1
            view?.setDataToPlayerScreen(
                attempts: playerHuman.attemptsToGuess,
                comparisonResult: result)
        }
    }

    private func whoWin() -> String {
        switch true {
        case playerHuman.attemptsToGuess < playerComputer.player.attemptsToGuess:
            return ResultType.win.rawValue
        case playerHuman.attemptsToGuess > playerComputer.player.attemptsToGuess:
            return ResultType.lose.rawValue
        case playerHuman.attemptsToGuess == playerComputer.player.attemptsToGuess:
            return ResultType.draw.rawValue
        default: return ""
        }
    }

    private func changeScreenType(screenType: ScreenType) {
        self.screenType = screenType
        initialDataForPlayers()
    }
}
