//
//  Renderer.swift
//  Engine
//
//  Created by Ben Scheirman on 12/3/19.
//  Copyright © 2019 Fickle Bits. All rights reserved.
//

public struct Renderer {
    public private(set) var bitmap: Bitmap

    public init(width: Int, height: Int) {
        self.bitmap = Bitmap(width: width, height: height, color: .black)
    }
}

public extension Renderer {
    mutating func draw(_ world: World) {
        let scale = Double(bitmap.height) / world.size.y

        // draw map
        for y in 0..<world.map.height {
            for x in 0..<world.map.width {
                let rect = Rect(
                    min: Vector(x: Double(x), y: Double(y)) * scale,
                    max: Vector(x: Double(x+1), y: Double(y+1)) * scale
                )
                if world.map[x, y].isWall {
                    bitmap.fill(rect: rect, color: .white)
                }
            }
        }

        // draw player
        var rect = world.player.rect
        rect.min *= scale
        rect.max *= scale
        bitmap.fill(rect: rect, color: .blue)
    }
}
