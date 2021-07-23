//
//  TicTacToeGridTests.swift
//  TicTacToeGridTests
//
//  Created by Suhayl Ahmed on 22/07/2021.
//

import XCTest

struct TicTacToeGrid {
    
    private let slots: [Coordinates: Player]
    
    init() {
        slots = [:]
    }
    
    private init(slots: [Coordinates: Player]) {
        self.slots = slots
    }
    
    func fillSlot(at coordinates: Coordinates, for player: Player) -> TicTacToeGrid? {
        guard isWithinGridBounds(coordinates: coordinates),
              slots[coordinates] == nil else { return nil }
        
        var newSlots =  slots
        newSlots[coordinates] = player
        
        return TicTacToeGrid(slots: newSlots)
    }
    
    func player(at coordinates: Coordinates) -> Player? {
        return .player1
    }
    
    private func isWithinGridBounds(coordinates: Coordinates) -> Bool {
        return (1...3 ~= coordinates.x) && (1...3 ~= coordinates.y)
    }
    
}

struct Coordinates: Hashable {
    let x, y: Int
}

enum Player {
    case player1, player2
}

class TicTacToeGridTests: XCTestCase {
    
    func test_fillSlot_xCoordinateCantBeNegative() {
        let sut = TicTacToeGrid()
        
        let negativeXCoordinates = Coordinates(x: -1, y: 1)
        
        XCTAssertNil(sut.fillSlot(at: negativeXCoordinates, for: .player1))
    }
    
    func test_fillSlot_yCoordinateCantBeNegative() {
        let sut = TicTacToeGrid()
        
        let negativeYCoordinates = Coordinates(x: 1, y: -1)
        
        XCTAssertNil(sut.fillSlot(at: negativeYCoordinates, for: .player1))
    }
    
    func test_fillSlot_xCoordinateCantBeZero() {
        let sut = TicTacToeGrid()
        
        let zeroXCoordinates = Coordinates(x: 0, y: -1)
        
        XCTAssertNil(sut.fillSlot(at: zeroXCoordinates, for: .player1))
    }
    
    func test_fillSlot_yCoordinateCantBeZero() {
        let sut = TicTacToeGrid()
        
        let zeroYCoordinates = Coordinates(x: 1, y: 0)
        
        XCTAssertNil(sut.fillSlot(at: zeroYCoordinates, for: .player1))
    }
    
    func test_fillSlot_xCoordinateCantBeGreaterThanThree() {
        let sut = TicTacToeGrid()
        
        let greaterThanThreeXCoordinates = Coordinates(x: 4, y: 1)
        
        XCTAssertNil(sut.fillSlot(at: greaterThanThreeXCoordinates, for: .player1))
    }
    
    func test_fillSlot_yCoordinateCantBeGreaterThanThree() {
        let sut = TicTacToeGrid()
        
        let greaterThanThreeYCoordinates = Coordinates(x: 1, y: 4)
        
        XCTAssertNil(sut.fillSlot(at: greaterThanThreeYCoordinates, for: .player1))
    }
    
    func test_fillSlot_canAddPlayerWithinGridBounds() {
        let sut = TicTacToeGrid()
        
        let coordinates = Coordinates(x: 1, y: 1)
        let grid = sut.fillSlot(at: coordinates, for: .player1)
        
        XCTAssertEqual(grid?.player(at: coordinates), Player.player1)
    }
    
    func test_fillSlot_cannotAddPlayerToAlreadyFilledSlot() {
        var sut: TicTacToeGrid? = TicTacToeGrid()
        
        let coordinates = Coordinates(x: 1, y: 1)
        sut = sut?.fillSlot(at: coordinates, for: .player1)
        
        XCTAssertNil(sut?.fillSlot(at: coordinates, for: .player1))
    }
    
}
