//
//  Billboard.swift
//  Engine
//
//  Created by Ben Scheirman on 12/11/19.
//  Copyright © 2019 Fickle Bits. All rights reserved.
//

public struct Billboard {
    public var start: Vector
    public var direction: Vector
    public var length: Double

    public init(start: Vector, direction: Vector, length: Double) {
        self.start = start
        self.direction = direction
        self.length = length
    }
}

public extension Billboard {
    var end: Vector {
        start + direction * length
    }

    func hitTest(_ ray: Ray) -> Vector? {
        let lhs = ray, rhs = Ray(origin: start, direction: direction)
        let (slope)
    }
}
