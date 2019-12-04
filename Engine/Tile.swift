//
//  Tile.swift
//  Engine
//
//  Created by Ben Scheirman on 12/4/19.
//  Copyright © 2019 Fickle Bits. All rights reserved.
//

import Foundation

public enum Tile : Int, Decodable {
    case floor
    case wall
}

public extension Tile {
    var isWall: Bool {
        switch self {
        case .wall:
            return true
        case .floor:
            return false
        }
    }
}
