//
//  PlayerModel.swift
//  GuessTheNumberTestTask
//
//  Created by Нагоев Магомед on 24.06.2022.
//

import Foundation

enum PlayerType {
    case computer
    case human
}

enum ComparisonOperator: String {
    case equal
    case less
    case more

    func getOperatorSign() -> String {
        switch self {
        case .equal:
            return "="
        case .less:
            return "<"
        case .more:
            return ">"
        }
    }
}

struct PlayerModel {
    var attemptsToGuess: Int = 0
    var myNumber: Int
}
