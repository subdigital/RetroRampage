//
//  Player.swift
//  Engine
//
//  Created by Ben Scheirman on 12/3/19.
//  Copyright © 2019 Fickle Bits. All rights reserved.
//

public struct Player {
    public var position: Vector
    public var velocity: Vector
    public let radius: Double = 0.25
    public let speed: Double = 3
    public let turningSpeed: Double = .pi
    public var direction: Vector
    
    public init(position: Vector) {
        self.position = position
        self.velocity = Vector.zero
        self.direction = Vector(x: 1, y: 0)
    }
}

extension Player {
    var rect: Rect {
        let halfSize = Vector(x: radius, y: radius)
        return Rect(min: position - halfSize, max: position + halfSize)
    }

    func intersection(with map: Tilemap) -> Vector? {
        let minX = Int(rect.min.x), maxX = Int(rect.max.x)
        let minY = Int(rect.min.y), maxY = Int(rect.max.y)
        var largestIntersection: Vector?
        for y in minY ... maxY {
            for x in minX ... maxX where map[x, y].isWall {
                let wallRect = Rect(
                    min: Vector(x: Double(x), y: Double(y)),
                    max: Vector(x: Double(x + 1), y: Double(y + 1))
                )
                if let intersection = rect.intersection(with: wallRect), intersection.length > largestIntersection?.length ?? 0 {
                    largestIntersection = intersection
                }
            }
        }
        return largestIntersection
    }

    mutating public func update(timeStep: Double) {
        position += velocity * timeStep

        position.x.formTruncatingRemainder(dividingBy: 8)
        position.y.formTruncatingRemainder(dividingBy: 8)
    }
}
