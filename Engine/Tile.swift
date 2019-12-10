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
    case crackWall
    case slimeWall
    case crackFloor
}

public extension Tile {
    var isWall: Bool {
        switch self {
        case .wall, .crackWall, .slimeWall:
            return true
        case .floor, .crackFloor:
            return false
        }
    }

    var textures: [Texture] {
        switch self {
        case .floor:
            return [.floor, .ceiling]
        case .crackFloor:
            return [.crackFloor, .ceiling]
        case .wall:
            return [.wall, .wall2]
        case .crackWall:
            return [.crackWall, .crackWall2]
        case .slimeWall:
            return [.slimeWall, .slimeWall2]
        }
    }
}
