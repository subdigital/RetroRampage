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
    public let radius: Double = 0.5
    
    public init(position: Vector) {
        self.position = position
        self.velocity = Vector(x: 1, y: 1)
    }
}

extension Player {
    var rect: Rect {
        let halfSize = Vector(x: radius, y: radius)
        return Rect(min: position - halfSize, max: position + halfSize)
    }


    mutating public func update(timeStep: Double) {
        position += velocity * timeStep

        position.x.formTruncatingRemainder(dividingBy: 8)
        position.y.formTruncatingRemainder(dividingBy: 8)
    }
}
