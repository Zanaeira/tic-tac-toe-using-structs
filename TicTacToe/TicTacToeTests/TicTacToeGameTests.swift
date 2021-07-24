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
        
        if newGrid.checkForWin() {
            return .winner(winner: currentPlayer)
        }
        
        if newGrid.checkForDraw() {
            return .draw
        }
        
        let player: Player = currentPlayer == .player1 ? .player2 : .player1
        let game = TicTacToeGame(nextPlayer: player, newGrid: newGrid)
        
        return .playing(game: game, nextPlayer: player)
    }
    
}

enum TicTacToeGameState {
    case playing(game: TicTacToeGame, nextPlayer: Player)
    case winner(winner: Player)
    case draw
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
    
    func test_playMove_returnsWinnerOnHorizontalWinningCombinations() {
        checkForHorizontalWin(row: 1)
        checkForHorizontalWin(row: 2)
        checkForHorizontalWin(row: 3)
    }
    
    func test_playMove_returnsWinnerOnVerticalWinningCombinations() {
        checkForVerticalWin(column: 1)
        checkForVerticalWin(column: 2)
        checkForVerticalWin(column: 3)
    }
    
    func test_playMove_returnsWinnerOnDiagonalWinningCombinations() {
        checkForTopLeftDiagonalWin()
        checkForBottomLeftDiagonalWin()
    }
    
    func test_playMove_returnsCorrectWinnerOnWin() {
        playWinningGame(for: .player1)
        playWinningGame(for: .player2)
    }
    
    func test_playMove_returnsDrawAtEndOfGameIfNoWinner() {
        var sut = TicTacToeGame()
        var gameState: TicTacToeGameState?
        
        let moves = movesForDraw()
        
        moves.forEach { coordinates in
            gameState = sut.playMove(at: coordinates)
            
            switch gameState! {
            case let .playing(gameInProgress, _):
                sut = gameInProgress
            case .draw:
                break
            case .winner:
                XCTFail("Game should have ended in draw")
            }
        }
        
        guard case TicTacToeGameState.draw = gameState! else {
            return XCTFail("Expected draw, but was \(gameState.debugDescription)")
        }
    }
    
    // MARK: - Helpers
    
    private func checkForHorizontalWin(row: Int, file: StaticString = #file, line: UInt = #line) {
        let winningCoordinates: [Coordinates] = [
            Coordinates(x: row, y: 1), Coordinates(x: row, y: 2), Coordinates(x: row, y: 3)
        ]
        let moves = makeDemoGameMoves(winningCoordinates: winningCoordinates, horizontalWin: true, rowOrColumnNumber: row)
        
        playWinningGame(usingMoves: moves, file: file, line: line)
    }
    
    private func checkForVerticalWin(column: Int, file: StaticString = #file, line: UInt = #line) {
        let winningCoordinates: [Coordinates] = [
            Coordinates(x: 1, y: column), Coordinates(x: 2, y: column), Coordinates(x: 3, y: column)
        ]
        let moves = makeDemoGameMoves(winningCoordinates: winningCoordinates, horizontalWin: false, rowOrColumnNumber: column)
        
        playWinningGame(usingMoves: moves, file: file, line: line)
    }
    
    private func checkForTopLeftDiagonalWin(file: StaticString = #file, line: UInt = #line) {
        let topLeftDiagonalWinCoordinates: [Coordinates] = [
            Coordinates(x: 1, y: 1), Coordinates(x: 2, y: 2), Coordinates(x: 3, y: 3)
        ]
        let moves = demoMovesForDiagonalWinGame(withWinningCoordinates: topLeftDiagonalWinCoordinates)
        
        playWinningGame(usingMoves: moves, file: file, line: line)
    }
    
    private func checkForBottomLeftDiagonalWin(file: StaticString = #file, line: UInt = #line) {
        let bottomLeftDiagonalWinCoordinates: [Coordinates] = [
            Coordinates(x: 1, y: 3), Coordinates(x: 2, y: 2), Coordinates(x: 3, y: 1)
        ]
        let moves = demoMovesForDiagonalWinGame(withWinningCoordinates: bottomLeftDiagonalWinCoordinates)
        
        playWinningGame(usingMoves: moves, file: file, line: line)
    }
    
    private func demoMovesForDiagonalWinGame(withWinningCoordinates winningCoordinates: [Coordinates]) -> [Coordinates] {
        return [winningCoordinates[0], Coordinates(x: 1, y: 2), winningCoordinates[1], Coordinates(x: 2, y: 3), winningCoordinates[2]]
    }
    
    private func makeDemoGameMoves(winningCoordinates: [Coordinates], horizontalWin: Bool, rowOrColumnNumber: Int) -> [Coordinates] {
        let opponentRowOrColumn = rowOrColumnNumber == 1 ? 2 : rowOrColumnNumber == 2 ? 3 : 2
        
        let moves: [Coordinates] =
            horizontalWin ? [winningCoordinates[0], Coordinates(x: opponentRowOrColumn, y: 1), winningCoordinates[1], Coordinates(x: opponentRowOrColumn, y: 2), winningCoordinates[2]] :
                            [winningCoordinates[0], Coordinates(x: 1, y: opponentRowOrColumn), winningCoordinates[1], Coordinates(x: 2, y: opponentRowOrColumn), winningCoordinates[2]]
        
        return moves
    }
    
    @discardableResult
    private func playWinningGame(usingMoves moves: [Coordinates], file: StaticString = #file, line: UInt = #line) -> TicTacToeGameState {
        var game = TicTacToeGame()
        var gameState: TicTacToeGameState?
        
        moves.forEach { coordinates in
            guard let newGameState = game.playMove(at: coordinates) else {
                return XCTFail("playMove returned nil")
            }
            
            switch newGameState {
            case let .playing(gameInProgress, _):
                game = gameInProgress
                gameState = newGameState
            case .draw:
                return XCTFail("Game should have ended in win, got draw")
            case .winner:
                gameState = newGameState
                break
            }
        }
        
        guard case TicTacToeGameState.winner = gameState! else {
            XCTFail("Expected winner state, got: \(gameState.debugDescription)")
            return gameState!
        }
        
        return gameState!
    }
    
    private func playWinningGame(for player: Player, file: StaticString = #file, line: UInt = #line) {
        let moves = player == .player1 ? movesForPlayerOneWin() : movesForPlayerTwoWin()
        
        let gameState = playWinningGame(usingMoves: moves, file: file, line: line)
        switch gameState {
        case let .winner(winner: winner):
            XCTAssertEqual(winner, player, "Expected winner: \(player), got: \(winner)")
        case .playing, .draw:
            XCTFail("Expected winner: \(player). Got playing state.")
        }
    }
    
    private func movesForPlayerOneWin() -> [Coordinates] {
        return [
            Coordinates(x: 1, y: 1),
            Coordinates(x: 2, y: 2),
            Coordinates(x: 3, y: 1),
            Coordinates(x: 2, y: 1),
            Coordinates(x: 2, y: 3),
            Coordinates(x: 3, y: 2),
            Coordinates(x: 1, y: 2),
            Coordinates(x: 3, y: 3),
            Coordinates(x: 1, y: 3)
        ]
    }
    
    private func movesForPlayerTwoWin() -> [Coordinates] {
        return [
            Coordinates(x: 1, y: 1),
            Coordinates(x: 2, y: 2),
            Coordinates(x: 3, y: 1),
            Coordinates(x: 2, y: 1),
            Coordinates(x: 2, y: 3),
            Coordinates(x: 3, y: 2),
            Coordinates(x: 3, y: 3),
            Coordinates(x: 1, y: 2)
        ]
    }
    
    private func movesForDraw() -> [Coordinates] {
        return [
            Coordinates(x: 1, y: 1),
            Coordinates(x: 2, y: 2),
            Coordinates(x: 3, y: 1),
            Coordinates(x: 2, y: 1),
            Coordinates(x: 2, y: 3),
            Coordinates(x: 3, y: 2),
            Coordinates(x: 1, y: 2),
            Coordinates(x: 1, y: 3),
            Coordinates(x: 3, y: 3)
        ]
    }
    
}
