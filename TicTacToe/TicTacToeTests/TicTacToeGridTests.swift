//
//  TicTacToeGridTests.swift
//  TicTacToeTests
//
//  Created by Suhayl Ahmed on 22/07/2021.
//

import XCTest
@testable import TicTacToe

class TicTacToeGridTests: XCTestCase {
    
    func test_fillSlot_xCoordinateCannotBeNegative() {
        let sut = TicTacToeGrid()
        
        let negativeXCoordinates = Coordinates(x: -1, y: 1)
        
        XCTAssertNil(sut.fillSlot(at: negativeXCoordinates, for: .player1))
    }
    
    func test_fillSlot_yCoordinateCannotBeNegative() {
        let sut = TicTacToeGrid()
        
        let negativeYCoordinates = Coordinates(x: 1, y: -1)
        
        XCTAssertNil(sut.fillSlot(at: negativeYCoordinates, for: .player1))
    }
    
    func test_fillSlot_xCoordinateCannotBeZero() {
        let sut = TicTacToeGrid()
        
        let zeroXCoordinates = Coordinates(x: 0, y: -1)
        
        XCTAssertNil(sut.fillSlot(at: zeroXCoordinates, for: .player1))
    }
    
    func test_fillSlot_yCoordinateCannotBeZero() {
        let sut = TicTacToeGrid()
        
        let zeroYCoordinates = Coordinates(x: 1, y: 0)
        
        XCTAssertNil(sut.fillSlot(at: zeroYCoordinates, for: .player1))
    }
    
    func test_fillSlot_xCoordinateCannotBeGreaterThanThree() {
        let sut = TicTacToeGrid()
        
        let greaterThanThreeXCoordinates = Coordinates(x: 4, y: 1)
        
        XCTAssertNil(sut.fillSlot(at: greaterThanThreeXCoordinates, for: .player1))
    }
    
    func test_fillSlot_yCoordinateCannotBeGreaterThanThree() {
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
    
    func test_fillSlot_canAddMultiplePlayers() {
        var sut: TicTacToeGrid? = TicTacToeGrid()
        
        let player1coordinates = Coordinates(x: 1, y: 1)
        sut = sut?.fillSlot(at: player1coordinates, for: .player1)
        
        let player2coordinates = Coordinates(x: 1, y: 2)
        sut = sut?.fillSlot(at: player2coordinates, for: .player2)
        
        XCTAssertEqual(sut?.player(at: player1coordinates), Player.player1)
        XCTAssertEqual(sut?.player(at: player2coordinates), Player.player2)
    }
    
    func test_fillSlot_cannotAddPlayerToAlreadyFilledSlot() {
        var sut: TicTacToeGrid? = TicTacToeGrid()
        
        let coordinates = Coordinates(x: 1, y: 1)
        sut = sut?.fillSlot(at: coordinates, for: .player1)
        
        XCTAssertNil(sut?.fillSlot(at: coordinates, for: .player1))
    }
    
}
