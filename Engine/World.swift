//
//  World.swift
//  Engine
//
//  Created by Ben Scheirman on 12/3/19.
//  Copyright © 2019 Fickle Bits. All rights reserved.
//

public struct World {
    public var player: Player!
    public let map: Tilemap

    public init(map: Tilemap) {
        self.map = map

        for y in 0 ..< map.width {
            for x in 0 ..< map.height {
                let position = Vector(x: Double(x) + 0.5, y: Double(y) + 0.5)
                let thing = map.things[y * map.width + x]
                switch thing {
                case .nothing: break
                case .player:
                    self.player = Player(position: position)
                }
            }
        }
    }
}

public extension World {
    var  size: Vector {
        map.size
    }

    mutating func update(timeStep: Double, input: Input) {
        player.velocity = input.velocity * player.speed
        player.position += player.velocity * timeStep

        while let intersection = player.intersection(with: map) {
            player.position -= intersection
        }
    }
}
