//
//  Coordinates.swift
//  TicTacToe
//
//  Created by Suhayl Ahmed on 23/07/2021.
//

import Foundation

public struct Coordinates: Hashable {
    let x, y: Int
    
    public init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
}
