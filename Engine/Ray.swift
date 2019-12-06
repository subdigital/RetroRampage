//
//  Ray.swift
//  Engine
//
//  Created by Ben Scheirman on 12/5/19.
//  Copyright © 2019 Fickle Bits. All rights reserved.
//

public struct Ray {
    public var origin, direction: Vector

    public init(origin: Vector, direction: Vector) {
        self.origin = origin
        self.direction = direction
    }
}
