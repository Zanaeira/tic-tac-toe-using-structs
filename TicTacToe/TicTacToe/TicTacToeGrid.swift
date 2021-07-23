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
    
    private func isWithinGridBounds(coordinates: Coordinates) -> Bool {
        return (1...3 ~= coordinates.x) && (1...3 ~= coordinates.y)
    }
    
    private func slotIsNotAlreadyFilled(at coordinates: Coordinates) -> Bool {
        return slots[coordinates] == nil
    }
    
}
