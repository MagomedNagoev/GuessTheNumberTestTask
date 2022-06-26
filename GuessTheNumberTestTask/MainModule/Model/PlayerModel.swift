//
//  PlayerModel.swift
//  GuessTheNumberTestTask
//
//  Created by Нагоев Магомед on 24.06.2022.
//

import Foundation

enum ResultType: String {
    case lose = "Computer Win"
    case win = "You Win"
    case draw = "Nobody won. Play again?"
}

enum ComparisonOperator: String {
    case equal
    case less
    case more
}

struct PlayerModel {
    var attemptsToGuess: Int = 1
    var myNumber: Int
}

struct ComputerPlayerModel {
    var player: PlayerModel
    var minGuessingNumber = 0
    var maxGuessingNumber = 100
}
