//
//  TicTacToeGameState.swift
//  TicTacToe
//
//  Created by Suhayl Ahmed on 24/07/2021.
//

import Foundation

public enum TicTacToeGameState {
    case playing(game: TicTacToeGame, nextPlayer: Player)
    case winner(winner: Player)
    case draw
}
