//
//  GameViewController.swift
//  GuessTheNumberTestTask
//
//  Created by Нагоев Магомед on 24.06.2022.
//

import UIKit

final class GameViewController: UIViewController {

    var presenter: GamePresenter!

    private var topLabel = UILabel(text: "Try № ",
                                       textAlignment: .center)
    private var guessingPlayerLabel = UILabel(text: "Computer is guessing",
                                              textAlignment: .center)
    private var computerGuesesNumberLabel = UILabel(text: "Your number is - 80 ?",
                                                    textAlignment: .center)
    private var humanTipLabel = UILabel(text: "My number is ...",
                                        textAlignment: .left)
    private var computerTipLabel = UILabel(text: "No, my number is less than yours",
                                        textAlignment: .center)
    private var humanTriesLabel = UILabel(text: "Your's tries count: ",
                                          textAlignment: .left)
    private var computerTriesLabel = UILabel(text: "Computers's tries count: ",
                                          textAlignment: .left)
    private var resultLabel = UILabel(text: "Somebody Win",
                                          textAlignment: .center)

    private var guessingTextField: NumberTextField = {
        let textField = NumberTextField()
        textField.isHidden = false
        return textField
    }()

    private var topLabelTopConstraint: NSLayoutConstraint?

    let stackView: UIStackView = {
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

        return button
    }()

    private var equelButton: UIButton = {
        let button = UIButton()
        button.comparisonButton(buttonName: "=")

        return button
    }()

    private var lessButton: UIButton = {
        let button = UIButton()
        button.comparisonButton(buttonName: "<")

        return button
    }()

    private var guessButton: UIButton = {
        let button = UIButton()
        button.blueButton(buttonName: "Guess")
        button.isHidden = false

        return button
    }()

    private var mainMenuButton: UIButton = {
        let button = UIButton()
        button.blueButton(buttonName: "Main Menu")
        button.isHidden = false
        button.addTarget(self, action: #selector(goToMainViewController), for: .touchUpInside)

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupStackView()
//        setupConstraintsToComputerScreen()
//        setupConstraintsToPlayerScreen()
        setupConstraintsToResultScreen()
    }

    @objc
    func goToMainViewController() {
        presenter.tapOnMainMenu()
    }

    func setupStackView() {
        stackView.addArrangedSubview(moreButton)
        stackView.addArrangedSubview(equelButton)
        stackView.addArrangedSubview(lessButton)
    }

    func setupConstraintsToComputerScreen() {

        let layoutGuide = view.safeAreaLayoutGuide
        topLabelTopConstraint = topLabel.topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: 50)
        guard let topLabelTopConstraint = topLabelTopConstraint else { return }

        view.addSubview(topLabel)
        NSLayoutConstraint.activate([
            topLabelTopConstraint,
            topLabel.leftAnchor.constraint(equalTo: layoutGuide.leftAnchor,
                                                 constant: 20),
            topLabel.rightAnchor.constraint(equalTo: layoutGuide.rightAnchor,
                                                  constant: -20)
        ])

        view.addSubview(guessingPlayerLabel)
        NSLayoutConstraint.activate([
            guessingPlayerLabel.topAnchor.constraint(equalTo: topLabel.bottomAnchor,
                                                constant: 20),
            guessingPlayerLabel.leftAnchor.constraint(equalTo: topLabel.leftAnchor),
            guessingPlayerLabel.rightAnchor.constraint(equalTo: topLabel.rightAnchor)
        ])

        view.addSubview(computerGuesesNumberLabel)
        NSLayoutConstraint.activate([
            computerGuesesNumberLabel.topAnchor.constraint(
                equalTo: guessingPlayerLabel.bottomAnchor,
                constant: 40),

            computerGuesesNumberLabel.leftAnchor.constraint(equalTo: topLabel.leftAnchor),
            computerGuesesNumberLabel.rightAnchor.constraint(equalTo: topLabel.rightAnchor)
        ])

        view.addSubview(humanTipLabel)
        NSLayoutConstraint.activate([
            humanTipLabel.topAnchor.constraint(equalTo: computerGuesesNumberLabel.bottomAnchor,
                                               constant: 300),
            humanTipLabel.leftAnchor.constraint(equalTo: layoutGuide.leftAnchor,
                                                constant: 80),
            humanTipLabel.rightAnchor.constraint(equalTo: layoutGuide.rightAnchor,
                                                 constant: -80)
        ])

        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: humanTipLabel.bottomAnchor,
                                           constant: 10),
            stackView.leftAnchor.constraint(equalTo: humanTipLabel.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: humanTipLabel.rightAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: layoutGuide.bottomAnchor,
                                              constant: -80)
        ])

        }

    func setupConstraintsToPlayerScreen() {
        let layoutGuide = view.safeAreaLayoutGuide
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.addArrangedSubview(guessingTextField)

        topLabelTopConstraint = topLabel.topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: 50)
        guard let topLabelTopConstraint = topLabelTopConstraint else { return }

        view.addSubview(topLabel)
        NSLayoutConstraint.activate([
            topLabelTopConstraint,
            topLabel.leftAnchor.constraint(equalTo: layoutGuide.leftAnchor,
                                                 constant: 20),
            topLabel.rightAnchor.constraint(equalTo: layoutGuide.rightAnchor,
                                                  constant: -20),
            topLabel.heightAnchor.constraint(equalToConstant: 20)
        ])

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

    func setupConstraintsToResultScreen() {
        let layoutGuide = view.safeAreaLayoutGuide

        topLabelTopConstraint = topLabel.topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: 50)
        guard let topLabelTopConstraint = topLabelTopConstraint else { return }

        view.addSubview(topLabel)
        NSLayoutConstraint.activate([
            topLabelTopConstraint,
            topLabel.leftAnchor.constraint(equalTo: layoutGuide.leftAnchor,
                                                 constant: 20),
            topLabel.rightAnchor.constraint(equalTo: layoutGuide.rightAnchor,
                                                  constant: -20),
            topLabel.heightAnchor.constraint(equalToConstant: 20)
        ])

        view.addSubview(humanTriesLabel)
        NSLayoutConstraint.activate([
            humanTriesLabel.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 150),
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
            resultLabel.topAnchor.constraint(greaterThanOrEqualTo: computerTriesLabel.bottomAnchor, constant: 10),
            resultLabel.leftAnchor.constraint(equalTo: topLabel.leftAnchor),
            resultLabel.rightAnchor.constraint(equalTo: topLabel.rightAnchor),
            resultLabel.heightAnchor.constraint(equalToConstant: 20)
        ])

        view.addSubview(mainMenuButton)
        NSLayoutConstraint.activate([
            mainMenuButton.topAnchor.constraint(equalTo: resultLabel.bottomAnchor,
                                                 constant: 75),
            mainMenuButton.leftAnchor.constraint(equalTo: layoutGuide.leftAnchor,
                                                  constant: 20),
            mainMenuButton.rightAnchor.constraint(equalTo: layoutGuide.rightAnchor,
                                                   constant: -20),
            mainMenuButton.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor,
                                                    constant: -50)
        ])
    }
}
