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
    public var monsters: [Monster]

    public init(map: Tilemap) {
        self.map = map
        monsters = []
        for y in 0 ..< map.width {
            for x in 0 ..< map.height {
                let position = Vector(x: Double(x) + 0.5, y: Double(y) + 0.5)
                let thing = map.things[y * map.width + x]
                switch thing {
                case .nothing: break
                case .player:
                    player = Player(position: position)
                case .monster:
                    monsters.append(Monster(position: position))
                }
            }
        }
    }
}

public extension World {
    var  size: Vector {
        map.size
    }

    var sprites: [Billboard] {
        let spritePlane = player.direction.orthogonal
        return monsters.map { monster in
            Billboard(start: monster.position - spritePlane/2, direction: spritePlane, length: 1)
        }
    }

    mutating func update(timeStep: Double, input: Input) {
        player.direction = player.direction.rotated(by: input.rotation)
        player.velocity = player.direction * input.speed * player.speed

        player.position += player.velocity * timeStep

        while let intersection = player.intersection(with: map) {
            player.position -= intersection
        }
    }
}
