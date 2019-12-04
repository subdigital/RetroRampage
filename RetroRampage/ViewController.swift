//
//  ViewController.swift
//  RetroRampage
//
//  Created by Ben Scheirman on 12/3/19.
//  Copyright © 2019 Fickle Bits. All rights reserved.
//

import UIKit
import Engine

class ViewController: UIViewController {

    private let imageView = UIImageView()
    private lazy var world = World(map: loadMap())
    private var lastFrameTime = CACurrentMediaTime()
    private let panGesture = UIPanGestureRecognizer()
    private let joystickRadius: Double = 40
    private let worldTimeStep: Double = 1 / 120

    private lazy var joystickDebugView: JoystickDebugView = {
        let jdbv = JoystickDebugView()
        jdbv.radius = CGFloat(joystickRadius)
        jdbv.backgroundColor = .clear
        jdbv.translatesAutoresizingMaskIntoConstraints = false
        return jdbv
    }()

    private var inputVector: Vector {
        joystickDebugView.update(pan: panGesture)

        switch panGesture.state {
        case .began, .changed:
            let translation = panGesture.translation(in: view)
            var vector = Vector(x: Double(translation.x), y: Double(translation.y))
            vector /= max(joystickRadius, vector.length)

            panGesture.setTranslation(CGPoint(
                x: vector.x * joystickRadius,
                y: vector.y * joystickRadius
            ), in: view)

            return vector

        default:
            return Vector.zero
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupImageView()
        setupJoystickDebugView()

        let displayLink = CADisplayLink(target: self, selector: #selector(update))
        displayLink.add(to: .main, forMode: .common)

        view.addGestureRecognizer(panGesture)
    }

    private func setupJoystickDebugView() {
        view.addSubview(joystickDebugView)
        NSLayoutConstraint.activate([
            joystickDebugView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            joystickDebugView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            joystickDebugView.topAnchor.constraint(equalTo: view.topAnchor),
            joystickDebugView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setupImageView() {
        view.addSubview(imageView)

        imageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .black
        imageView.layer.magnificationFilter = .nearest
    }

    private func loadMap() -> Tilemap {
        let jsonURL = Bundle.main.url(forResource: "Map", withExtension: "json")!
        let jsonData = try! Data(contentsOf: jsonURL)
        return try! JSONDecoder().decode(Tilemap.self, from: jsonData)
    }

    @objc
    func update(_ displayLink: CADisplayLink) {

        let input = Input(velocity: inputVector)
        let timeStep = displayLink.timestamp - lastFrameTime
        let worldSteps = (timeStep / worldTimeStep).rounded(.up)
        for _ in 0 ..< Int(worldSteps) {
            world.update(timeStep: timeStep / worldSteps, input: input)
        }

        let size = Int(min(imageView.bounds.width, imageView.bounds.height))
        var renderer = Renderer(width: size, height: size)
        renderer.draw(world)
        imageView.image = UIImage(bitmap: renderer.bitmap)

        lastFrameTime = displayLink.timestamp
    }
}

