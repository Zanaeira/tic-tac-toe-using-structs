//
//  TicTacToeGameTests.swift
//  TicTacToeTests
//
//  Created by Suhayl Ahmed on 23/07/2021.
//

import XCTest
import TicTacToe

struct TicTacToeGame {
    
    private let nextPlayer: Player
    
    init() {
        nextPlayer = .player1
    }
    
    private init(player: Player) {
        nextPlayer = player
    }
    
    func playMove(at coordinates: Coordinates) -> TicTacToeGameState {
        let player: Player = nextPlayer == .player1 ? .player2 : .player1
        let game = TicTacToeGame(player: player)
        
        return .playing(game: game, nextPlayer: player)
    }
    
}

enum TicTacToeGameState {
    case playing(game: TicTacToeGame, nextPlayer: Player)
}

class TicTacToeGameTests: XCTestCase {
    
    func test_playTurn_alternatesBetweenPlayers() {
        let sut = TicTacToeGame()
        
        let coordinates1 = Coordinates(x: 1, y: 1)
        let newGameState = sut.playMove(at: coordinates1)
        guard case let TicTacToeGameState.playing(game, nextPlayer) = newGameState else {
            return XCTFail("playMove did not return playing state with game and nextPlayer")
        }
        
        XCTAssertEqual(nextPlayer, Player.player2)
        
        let coordinates2 = Coordinates(x: 1, y: 2)
        guard case let TicTacToeGameState.playing(_, nextPlayer) = game.playMove(at: coordinates2) else {
            return XCTFail("playMove did not return playing state with game and nextPlayer")
        }
        
        XCTAssertEqual(nextPlayer, Player.player1)
    }
    
}
