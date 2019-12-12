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
        var lhs = ray, rhs = Ray(origin: start, direction: direction)

        // Ensure rays are never exactly vertical
        let epsilon = 0.00001
        if abs(lhs.direction.x) < epsilon {
            lhs.direction.x = epsilon
        }
        if abs(rhs.direction.x) < epsilon {
            rhs.direction.x = epsilon
        }

        let (slope1, intercept1) = lhs.slopeIntercept
        let (slope2, intercept2) = rhs.slopeIntercept

        // parallel?
        if slope1 == slope2 {
            return nil
        }

        // find intersection point
        let x = (intercept1 - intercept2) / (slope2 - slope1)
        let y = slope1 * x + intercept1

        // make sure it's not behind us
        let distanceAlongRay = (x - lhs.origin.x) / lhs.direction.x
        if distanceAlongRay < 0 {
            return nil
        }

        // make sure we check only in the plane of the billboard
        let distanceAlongBillboard = (x - rhs.origin.x) / rhs.direction.x
        if distanceAlongBillboard < 0 || distanceAlongBillboard > length {
            return nil
        }


        return Vector(x: x, y: y)
    }
}


