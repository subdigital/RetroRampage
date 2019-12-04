//
//  Tilemap.swift
//  Engine
//
//  Created by Ben Scheirman on 12/4/19.
//  Copyright © 2019 Fickle Bits. All rights reserved.
//

import Foundation

public struct Tilemap : Decodable {
    private let tiles: [Tile]
    public let width: Int
    public let things: [Thing]
}

public extension Tilemap {
    var height: Int {
        tiles.count / width
    }

    var size: Vector {
        Vector(x: Double(width), y: Double(height))
    }

    subscript(x: Int, y: Int) -> Tile {
        tiles[y * width + x]
    }
}
