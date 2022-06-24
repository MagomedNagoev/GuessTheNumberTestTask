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
    private var gameLabel = UILabel(text: "My Awesome Game", textAlignment: .center)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstraints()
    }

    @objc
    func startGame() {
        presenter.tapOnNewGameButton()
    }

    func setupConstraints() {
        let layoutGuide = view.safeAreaLayoutGuide

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
    }
}
