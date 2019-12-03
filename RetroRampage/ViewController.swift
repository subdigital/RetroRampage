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
    private var world = World()
    private var lastFrameTime = CACurrentMediaTime()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupImageView()

        let displayLink = CADisplayLink(target: self, selector: #selector(update))
        displayLink.add(to: .main, forMode: .common)
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

    @objc
    func update(_ displayLink: CADisplayLink) {
        let timeStep = displayLink.timestamp - lastFrameTime
        world.update(timeStep: timeStep)

        let size = Int(min(imageView.bounds.width, imageView.bounds.height))
        var renderer = Renderer(width: size, height: size)
        renderer.draw(world)
        imageView.image = UIImage(bitmap: renderer.bitmap)

        lastFrameTime = displayLink.timestamp
    }
}

