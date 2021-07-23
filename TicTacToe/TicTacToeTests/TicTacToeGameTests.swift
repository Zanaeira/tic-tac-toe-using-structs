//
//  TicTacToeGameTests.swift
//  TicTacToeTests
//
//  Created by Suhayl Ahmed on 23/07/2021.
//

import XCTest
import TicTacToe

struct TicTacToeGame {
    
    private let currentPlayer: Player
    private let grid: TicTacToeGrid
    
    init() {
        currentPlayer = .player1
        grid = TicTacToeGrid()
    }
    
    private init(nextPlayer: Player, newGrid: TicTacToeGrid) {
        currentPlayer = nextPlayer
        grid = newGrid
    }
    
    func playMove(at coordinates: Coordinates) -> TicTacToeGameState? {
        guard let newGrid = grid.fillSlot(at: coordinates, for: currentPlayer) else { return nil }
        
        let player: Player = currentPlayer == .player1 ? .player2 : .player1
        let game = TicTacToeGame(nextPlayer: player, newGrid: newGrid)
        
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
        guard let newGameState = sut.playMove(at: coordinates1) else {
            return XCTFail("playMove returned nil")
        }
        guard case let TicTacToeGameState.playing(game, nextPlayer) = newGameState else {
            return XCTFail("playMove did not return playing state with game and nextPlayer")
        }
        
        XCTAssertEqual(nextPlayer, Player.player2)
        
        let coordinates2 = Coordinates(x: 1, y: 2)
        guard let newGameState = game.playMove(at: coordinates2) else {
            return XCTFail("playMove returned nil")
        }
        guard case let TicTacToeGameState.playing(_, nextPlayer) = newGameState else {
            return XCTFail("playMove did not return playing state with game and nextPlayer")
        }
        
        XCTAssertEqual(nextPlayer, Player.player1)
    }
    
    func test_playMove_returnsNilOnOutOfBoundsCoordinates() {
        let sut = TicTacToeGame()
        
        let negativeXCoordinate = Coordinates(x: -1, y: 1)
        XCTAssertNil(sut.playMove(at: negativeXCoordinate), "Negative x-coordinate should result in nil for playMove")
        
        let negativeYCoordinate = Coordinates(x: 1, y: -1)
        XCTAssertNil(sut.playMove(at: negativeYCoordinate), "Negative y-coordinate should result in nil for playMove")
        
        let zeroXCoordinate = Coordinates(x: 0, y: 1)
        XCTAssertNil(sut.playMove(at: zeroXCoordinate), "Zero x-coordinate should result in nil for playMove")
        
        let zeroYCoordinate = Coordinates(x: 1, y: 0)
        XCTAssertNil(sut.playMove(at: zeroYCoordinate), "Zero y-coordinate should result in nil for playMove")
        
        let greaterThanThreeXCoordinate = Coordinates(x: 4, y: 1)
        XCTAssertNil(sut.playMove(at: greaterThanThreeXCoordinate), "Greater than 3 x-coordinate should result in nil for playMove")
        
        let greaterThanThreeYCoordinate = Coordinates(x: 1, y: 4)
        XCTAssertNil(sut.playMove(at: greaterThanThreeYCoordinate), "Greater than 3 y-coordinate should result in nil for playMove")
    }
    
    func test_playMove_returnsNilOnPlayingSameCoordinates() {
        let sut = TicTacToeGame()
        
        let coordinates = Coordinates(x: 1, y: 1)
        guard let newGameState = sut.playMove(at: coordinates) else {
            return XCTFail("playMove returned nil")
        }
        guard case let TicTacToeGameState.playing(game, _) = newGameState else {
            return XCTFail("playMove did not return playing state with game and nextPlayer")
        }
        
        XCTAssertNil(game.playMove(at: coordinates))
    }
    
}
