//
//  MainViewController.swift
//  GuessTheNumberTestTask
//
//  Created by Нагоев Магомед on 24.06.2022.
//

import UIKit

final class MainViewController: UIViewController {

    var presenter: MainPresenterProtocol!

    private var startGameButton: UIButton = {
        let button = UIButton()
        button.blueButton(buttonName: "Start New Game")
        button.addTarget(self, action: #selector(startGame), for: .touchUpInside)
        return button
    }()

    private var enterTheNumberButton: UIButton = {
        let button = UIButton()
        button.blueButton(buttonName: "Enter the Number")
        button.addTarget(self, action: #selector(enterNumber), for: .touchUpInside)
        button.isHidden = true
        button.isEnabled = false
        button.alpha = 0.75
        return button
    }()

    private var gameLabel = UILabel(text: "My Awesome Game", textAlignment: .center)

    private var guessTheNumberTextfield: NumberTextField = {
        let textField = NumberTextField()
        textField.addTarget(self, action: #selector(textFieldTarget),
                            for: .allEditingEvents)
        return textField
    }()

    var enterTheNumberButtonBottomConstraint: NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstraints()

        setupDismissKeyboardGesture()
        setupKeyboardHiding()
    }

    @objc
    func startGame() {
        startGameButton.isHidden = true
        gameLabel.isHidden = true

        guessTheNumberTextfield.isHidden = false
        enterTheNumberButton.isHidden = false
    }

    @objc
    func enterNumber() {
        if let numberString = guessTheNumberTextfield.text,
           let numberInt = Int(numberString) {
            presenter.setPlayerHumanNumber(playerNumber: numberInt)
            presenter.tapOnEnterTheNumber()
        }
    }

    @objc
    func textFieldTarget() {
        if guessTheNumberTextfield.hasText {
            enterTheNumberButton.alpha = 1
            enterTheNumberButton.isEnabled = true
        }
    }

    func setupConstraints() {
        let layoutGuide = view.safeAreaLayoutGuide

        enterTheNumberButtonBottomConstraint =
            enterTheNumberButton.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: -50)

        view.addSubview(gameLabel)
        NSLayoutConstraint.activate([
            gameLabel.topAnchor.constraint(equalTo: layoutGuide.topAnchor,
                                                 constant: 100),
            gameLabel.leftAnchor.constraint(equalTo: layoutGuide.leftAnchor),
            gameLabel.rightAnchor.constraint(equalTo: layoutGuide.rightAnchor)
        ])

        view.addSubview(startGameButton)
        NSLayoutConstraint.activate([
            startGameButton.topAnchor.constraint(greaterThanOrEqualTo: gameLabel.topAnchor,
                                                 constant: 15),
            startGameButton.leftAnchor.constraint(equalTo: layoutGuide.leftAnchor,
                                                  constant: 20),
            startGameButton.rightAnchor.constraint(equalTo: layoutGuide.rightAnchor,
                                                   constant: -20),
            startGameButton.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor,
                                                    constant: -50)
        ])

        view.addSubview(guessTheNumberTextfield)
        NSLayoutConstraint.activate([
            guessTheNumberTextfield.topAnchor.constraint(equalTo: layoutGuide.topAnchor,
                                                 constant: 100),
            guessTheNumberTextfield.leftAnchor.constraint(equalTo: layoutGuide.leftAnchor,
                                                  constant: 20),
            guessTheNumberTextfield.rightAnchor.constraint(equalTo: layoutGuide.rightAnchor,
                                                   constant: -20)
        ])

        guard let enterTheNumberButtonBottomConstraint = enterTheNumberButtonBottomConstraint else { return }

        view.addSubview(enterTheNumberButton)
        NSLayoutConstraint.activate([
            enterTheNumberButton.topAnchor.constraint(greaterThanOrEqualTo: gameLabel.topAnchor,
                                                 constant: 15),
            enterTheNumberButton.leftAnchor.constraint(equalTo: guessTheNumberTextfield.leftAnchor),
            enterTheNumberButton.rightAnchor.constraint(equalTo: guessTheNumberTextfield.rightAnchor),
            enterTheNumberButtonBottomConstraint
        ])
    }
}
