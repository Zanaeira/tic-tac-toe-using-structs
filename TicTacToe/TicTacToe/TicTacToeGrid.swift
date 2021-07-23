//
//  TicTacToeGrid.swift
//  TicTacToe
//
//  Created by Suhayl Ahmed on 23/07/2021.
//

import Foundation

public struct TicTacToeGrid {
    
    private let slots: [Coordinates: Player]
    
    public init() {
        slots = [:]
    }
    
    private init(slots: [Coordinates: Player]) {
        self.slots = slots
    }
    
    public func fillSlot(at coordinates: Coordinates, for player: Player) -> TicTacToeGrid? {
        guard isWithinGridBounds(coordinates: coordinates),
              slotIsNotAlreadyFilled(at: coordinates) else { return nil }
        
        var newSlots =  slots
        newSlots[coordinates] = player
        
        return TicTacToeGrid(slots: newSlots)
    }
    
    public func player(at coordinates: Coordinates) -> Player? {
        return slots[coordinates]
    }
    
    public func checkForWin() -> Bool {
        for i in 1...3 {
            var currentPlayer = player(at: Coordinates(x: i, y: 1))
            
            if currentPlayer != nil &&
                currentPlayer == player(at: Coordinates(x: i, y: 2)) &&
                currentPlayer == player(at: Coordinates(x: i, y: 3)) {
                return true
            }
            
            currentPlayer = player(at: Coordinates(x: 1, y: i))
            
            if currentPlayer != nil &&
                currentPlayer == player(at: Coordinates(x: 2, y: i)) &&
                currentPlayer == player(at: Coordinates(x: 3, y: i)) {
                return true
            }
        }
        
        var currentPlayer = player(at: Coordinates(x: 1, y: 1))
        if currentPlayer != nil &&
            currentPlayer == player(at: Coordinates(x: 2, y: 2)) &&
            currentPlayer == player(at: Coordinates(x: 3, y: 3)) {
            return true
        }
        
        currentPlayer = player(at: Coordinates(x: 1, y: 3))
        if currentPlayer != nil &&
            currentPlayer == player(at: Coordinates(x: 2, y: 2)) &&
            currentPlayer == player(at: Coordinates(x: 3, y: 1)) {
            return true
        }
        
        return false
    }
    
    private func isWithinGridBounds(coordinates: Coordinates) -> Bool {
        return (1...3 ~= coordinates.x) && (1...3 ~= coordinates.y)
    }
    
    private func slotIsNotAlreadyFilled(at coordinates: Coordinates) -> Bool {
        return slots[coordinates] == nil
    }
    
}
