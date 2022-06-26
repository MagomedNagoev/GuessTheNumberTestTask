//
//  GameViewController.swift
//  GuessTheNumberTestTask
//
//  Created by Нагоев Магомед on 24.06.2022.
//

import UIKit

final class GameViewController: UIViewController {

    var presenter: GamePresenterProtocol!

    // MARK: - Private properties

    private var topLabel = UILabel(textAlignment: .center)
    private var guessingPlayerLabel = UILabel(text: "Computer is guessing",
                                              textAlignment: .center)
    private var computerGuesesNumberLabel = UILabel(textAlignment: .center)
    private var humanTipLabel = UILabel(text: "My number is ...",
                                        textAlignment: .left)
    private var computerTipLabel = UILabel(textAlignment: .center)
    private var humanTriesLabel = UILabel(textAlignment: .left)
    private var computerTriesLabel = UILabel(textAlignment: .left)
    private var resultLabel = UILabel(textAlignment: .center)

    private var guessingTextField: NumberTextField = {
        let textField = NumberTextField()
        return textField
    }()

    private var topLabelTopConstraint: NSLayoutConstraint?

    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution  = UIStackView.Distribution.fillEqually
        stackView.alignment = UIStackView.Alignment.fill
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()

    private var moreButton: UIButton = {
        let button = UIButton()
        button.comparisonButton(buttonName: ">")
        button.addTarget(self, action: #selector(tapOnMoreNumber), for: .touchUpInside)
        return button
    }()

    private var equelButton: UIButton = {
        let button = UIButton()
        button.comparisonButton(buttonName: "=")
        button.addTarget(self, action: #selector(tapOnEquelNumber), for: .touchUpInside)
        return button
    }()

    private var lessButton: UIButton = {
        let button = UIButton()
        button.comparisonButton(buttonName: "<")
        button.addTarget(self, action: #selector(tapOnLessNumber), for: .touchUpInside)
        return button
    }()

    private var guessButton: UIButton = {
        let button = UIButton()
        button.blueButton(buttonName: "Guess")
        button.isHidden = false
        button.addTarget(self, action: #selector(guessNumber), for: .touchUpInside)
        return button
    }()

    private var mainMenuButton: UIButton = {
        let button = UIButton()
        button.blueButton(buttonName: "Main Menu")
        button.isHidden = false
        button.addTarget(self, action: #selector(goToMainViewController), for: .touchUpInside)

        return button
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupStackView()
        setupConstraintsToComputerScreen()
        setupConstraintsToPlayerScreen()
        setupConstraintsToResultScreen()
        hideKeyboardOnTap()
    }

    // MARK: - Methods

    @objc
    func goToMainViewController() {
        presenter.tapOnMainMenu()
    }

    @objc
    func tapOnMoreNumber() {
        presenter.moreNumber()
    }

    @objc
    func tapOnLessNumber() {
        presenter.lessNumber()
    }

    @objc
    func tapOnEquelNumber() {
        presenter.equalNumber()
    }

    @objc
    func guessNumber() {
        if let numberString = guessingTextField.text,
           let number = Int(numberString) {
            presenter.compareNumbers(playerGuessNumber: number)
        }
    }

    func setupStackView() {
        stackView.addArrangedSubview(moreButton)
        stackView.addArrangedSubview(equelButton)
        stackView.addArrangedSubview(lessButton)
    }

    func setupPlayerScreen() {
        topLabel.isHidden = false
        guessingPlayerLabel.isHidden = false
        computerGuesesNumberLabel.isHidden = true
        humanTipLabel.isHidden = true
        computerTipLabel.isHidden = true
        humanTriesLabel.isHidden = true
        computerTriesLabel.isHidden = true
        resultLabel.isHidden = true
        guessingTextField.isHidden = false
        stackView.isHidden = true
        mainMenuButton.isHidden = true
        guessButton.isHidden = false
        topLabelTopConstraint?.constant = 75
        guessingPlayerLabel.text = "You are guessing"
        view.upAnimate()
    }

    func setupComputerScreen() {
        topLabel.isHidden = false
        guessingPlayerLabel.isHidden = false
        computerGuesesNumberLabel.isHidden = false
        humanTipLabel.isHidden = false
        computerTipLabel.isHidden = true
        humanTriesLabel.isHidden = true
        computerTriesLabel.isHidden = true
        resultLabel.isHidden = true
        guessingTextField.isHidden = true
        stackView.isHidden = false
        mainMenuButton.isHidden = true
        guessButton.isHidden = true
    }

    func setupResultScreen() {
        topLabel.text = "Scores:"
        topLabel.isHidden = false
        guessingPlayerLabel.isHidden = true
        computerGuesesNumberLabel.isHidden = true
        humanTipLabel.isHidden = true
        computerTipLabel.isHidden = true
        humanTriesLabel.isHidden = false
        computerTriesLabel.isHidden = false
        resultLabel.isHidden = false
        guessingTextField.isHidden = true
        stackView.isHidden = true
        mainMenuButton.isHidden = false
        guessButton.isHidden = true
        view.upAnimate()
    }
}

// MARK: Constraints
extension GameViewController {
    private func setupConstraintsToComputerScreen() {

        let layoutGuide = view.safeAreaLayoutGuide
        topLabelTopConstraint = topLabel.topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: 50)
        guard let topLabelTopConstraint = topLabelTopConstraint else { return }

        view.addSubview(topLabel)
        NSLayoutConstraint.activate([
            topLabelTopConstraint,
            topLabel.leftAnchor.constraint(equalTo: layoutGuide.leftAnchor, constant: 20),
            topLabel.rightAnchor.constraint(equalTo: layoutGuide.rightAnchor, constant: -20),
            topLabel.heightAnchor.constraint(equalToConstant: 20)
        ])

        view.addSubview(guessingPlayerLabel)
        NSLayoutConstraint.activate([
            guessingPlayerLabel.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 20),
            guessingPlayerLabel.leftAnchor.constraint(equalTo: topLabel.leftAnchor),
            guessingPlayerLabel.rightAnchor.constraint(equalTo: topLabel.rightAnchor),
            guessingPlayerLabel.heightAnchor.constraint(equalToConstant: 20)
        ])

        view.addSubview(computerGuesesNumberLabel)
        NSLayoutConstraint.activate([
            computerGuesesNumberLabel.topAnchor.constraint(
                equalTo: guessingPlayerLabel.bottomAnchor, constant: 40),

            computerGuesesNumberLabel.leftAnchor.constraint(equalTo: topLabel.leftAnchor),
            computerGuesesNumberLabel.rightAnchor.constraint(equalTo: topLabel.rightAnchor),
            guessingPlayerLabel.heightAnchor.constraint(equalToConstant: 20)
        ])

        view.addSubview(humanTipLabel)
        NSLayoutConstraint.activate([
            humanTipLabel.topAnchor.constraint(lessThanOrEqualTo: computerGuesesNumberLabel.bottomAnchor,
                                               constant: 300),
            humanTipLabel.leftAnchor.constraint(equalTo: layoutGuide.leftAnchor, constant: 80),
            humanTipLabel.rightAnchor.constraint(equalTo: layoutGuide.rightAnchor, constant: -80),
            guessingPlayerLabel.heightAnchor.constraint(equalToConstant: 20)
        ])

        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: humanTipLabel.bottomAnchor, constant: 10),
            stackView.leftAnchor.constraint(equalTo: humanTipLabel.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: humanTipLabel.rightAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: layoutGuide.bottomAnchor,
                                              constant: -30)
        ])

        }

    private func setupConstraintsToPlayerScreen() {
        let layoutGuide = view.safeAreaLayoutGuide
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.addArrangedSubview(guessingTextField)

        view.addSubview(guessingPlayerLabel)
        NSLayoutConstraint.activate([
            guessingPlayerLabel.topAnchor.constraint(equalTo: topLabel.bottomAnchor,
                                                constant: 20),
            guessingPlayerLabel.leftAnchor.constraint(equalTo: topLabel.leftAnchor),
            guessingPlayerLabel.rightAnchor.constraint(equalTo: topLabel.rightAnchor),
            guessingPlayerLabel.heightAnchor.constraint(equalToConstant: 20)
        ])

        view.addSubview(guessButton)
        NSLayoutConstraint.activate([
            guessButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            guessButton.leftAnchor.constraint(equalTo: layoutGuide.leftAnchor,
                                                 constant: 20),
            guessButton.rightAnchor.constraint(equalTo: layoutGuide.rightAnchor,
                                                  constant: -20)
        ])

        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: guessingPlayerLabel.bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: guessingPlayerLabel.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: guessingPlayerLabel.rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: guessButton.topAnchor)
        ])

        view.addSubview(computerTipLabel)
        NSLayoutConstraint.activate([
            computerTipLabel.topAnchor.constraint(equalTo: guessButton.bottomAnchor,
                                                  constant: 30),
            computerTipLabel.leftAnchor.constraint(equalTo: guessingPlayerLabel.leftAnchor),
            computerTipLabel.rightAnchor.constraint(equalTo: guessingPlayerLabel.rightAnchor),
            computerTipLabel.bottomAnchor.constraint(lessThanOrEqualTo: layoutGuide.bottomAnchor)
        ])
    }

    private func setupConstraintsToResultScreen() {
        let layoutGuide = view.safeAreaLayoutGuide

        view.addSubview(humanTriesLabel)
        NSLayoutConstraint.activate([
            humanTriesLabel.topAnchor.constraint(lessThanOrEqualTo: topLabel.bottomAnchor, constant: 150),
            humanTriesLabel.leftAnchor.constraint(equalTo: topLabel.leftAnchor),
            humanTriesLabel.rightAnchor.constraint(equalTo: topLabel.rightAnchor),
            humanTriesLabel.heightAnchor.constraint(equalToConstant: 20)
        ])

        view.addSubview(computerTriesLabel)
        NSLayoutConstraint.activate([
            computerTriesLabel.topAnchor.constraint(equalTo: humanTriesLabel.bottomAnchor, constant: 20),
            computerTriesLabel.leftAnchor.constraint(equalTo: topLabel.leftAnchor),
            computerTriesLabel.rightAnchor.constraint(equalTo: topLabel.rightAnchor),
            computerTriesLabel.heightAnchor.constraint(equalToConstant: 20)
        ])

        view.addSubview(resultLabel)
        NSLayoutConstraint.activate([
            resultLabel.topAnchor.constraint(greaterThanOrEqualTo: computerTriesLabel.bottomAnchor, constant: 20),
            resultLabel.leftAnchor.constraint(equalTo: topLabel.leftAnchor),
            resultLabel.rightAnchor.constraint(equalTo: topLabel.rightAnchor),
            resultLabel.heightAnchor.constraint(equalToConstant: 20)
        ])

        view.addSubview(mainMenuButton)
        NSLayoutConstraint.activate([
            mainMenuButton.topAnchor.constraint(greaterThanOrEqualTo: resultLabel.bottomAnchor,
                                                 constant: 40),
            mainMenuButton.leftAnchor.constraint(equalTo: layoutGuide.leftAnchor,
                                                  constant: 20),
            mainMenuButton.rightAnchor.constraint(equalTo: layoutGuide.rightAnchor,
                                                   constant: -20),
            mainMenuButton.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor,
                                                    constant: -50)
        ])
    }
}

// MARK: - Extension
extension GameViewController: GameViewProtocol {
    func missClick() {
        callAlert(message: "Please click other button")
    }

    func setDataToResultScreen(humanTries: Int,
                               computerTries: Int,
                               resultGame: String) {
        humanTriesLabel.text = "Your's tries count: \(humanTries)"
        computerTriesLabel.text = "Computers's tries count: \(computerTries)"
        resultLabel.text = resultGame
    }

    func setDataToPlayerScreen(attempts: Int,
                               comparisonResult: String) {
        if computerTipLabel.isHidden {
            computerTipLabel.isHidden = false
        }

        topLabel.text = "Try № \(attempts)"
        computerTipLabel.text = "No, my number is \(comparisonResult) than yours"
    }

    func setDataToComputerScreen(attempts: Int, guessNumber: Int) {
        topLabel.text = "Try № \(attempts)"
        computerGuesesNumberLabel.text = "Your number is - \(guessNumber) ?"
    }
}
