//
//  TicTacToeGame.swift
//  TicTacToe
//
//  Created by Suhayl Ahmed on 24/07/2021.
//

import Foundation

public struct TicTacToeGame {
    
    private let currentPlayer: Player
    private let grid: TicTacToeGrid
    
    public init() {
        currentPlayer = .player1
        grid = TicTacToeGrid()
    }
    
    private init(nextPlayer: Player, newGrid: TicTacToeGrid) {
        currentPlayer = nextPlayer
        grid = newGrid
    }
    
    public func playMove(at coordinates: Coordinates) -> TicTacToeGameState? {
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
