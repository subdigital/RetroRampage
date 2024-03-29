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

    func hitTest(_ ray: Ray) -> Vector {
        var position = ray.origin
        let slope = ray.direction.x / ray.direction.y
        repeat {
            let edgeDistanceX, edgeDistanceY: Double
            if ray.direction.x > 0 {
                edgeDistanceX = position.x.rounded(.down) + 1 - position.x
            } else {
                edgeDistanceX = position.x.rounded(.up) - 1 - position.x
            }
            if ray.direction.y > 0 {
                edgeDistanceY = position.y.rounded(.down) + 1 - position.y
            } else {
                edgeDistanceY = position.y.rounded(.up) - 1 - position.y
            }

            let step1 = Vector(x: edgeDistanceX, y: edgeDistanceX / slope)
            let step2 = Vector(x: edgeDistanceY * slope, y: edgeDistanceY)

            if step1.length < step2.length {
                position += step1
            } else {
                position += step2
            }

        } while tile(at: position, from: ray.direction).isWall == false

        return position
    }

    func tile(at position: Vector, from direction: Vector) -> Tile {
        var offsetX = 0, offsetY = 0
        if position.x.rounded(.down) == position.x {
            offsetX = direction.x > 0 ? 0 : -1
        }
        if position.y.rounded(.down) == position.y {
            offsetY = direction.y > 0 ? 0 : -1
        }
        return self[Int(position.x) + offsetX, Int(position.y) + offsetY]
    }
}
