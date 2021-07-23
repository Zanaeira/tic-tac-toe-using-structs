//
//  TicTacToeGridTests.swift
//  TicTacToeGridTests
//
//  Created by Suhayl Ahmed on 22/07/2021.
//

import XCTest

struct TicTacToeGrid {
    
    func fillSlot(at coordinates: Coordinates) -> TicTacToeGrid? {
        return nil
    }
    
}

struct Coordinates {
    let x, y: Int
}

class TicTacToeGridTests: XCTestCase {

    func test_fillSlot_xCoordinateCantBeNegative() {
        let sut = TicTacToeGrid()
        
        let negativeXCoordinates = Coordinates(x: -1, y: 1)
        
        XCTAssertNil(sut.fillSlot(at: negativeXCoordinates))
    }
    
    func test_fillSlot_yCoordinateCantBeNegative() {
        let sut = TicTacToeGrid()
        
        let negativeYCoordinates = Coordinates(x: 1, y: -1)
        
        XCTAssertNil(sut.fillSlot(at: negativeYCoordinates))
    }

}
