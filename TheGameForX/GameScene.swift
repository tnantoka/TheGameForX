//
//  GameScene.swift
//  TheGameForX
//
//  Created by Tatsuya Tobioka on 2017/09/14.
//  Copyright © 2017 tnantoka. All rights reserved.
//

import UIKit
import SpriteKit

class GameScene: SKScene {

//    let debug = false
    let debug = true

    let texture = SKTexture(imageNamed: "StatusBar")

    lazy var label: SKLabelNode = {
        let label = SKLabelNode(text: "0")
        label.position = CGPoint(
            x: size.width / 2.0,
            y: size.height / 2.0
        )
        if debug {
            label.position.y = size.height * 0.85
        }
        label.fontColor = .black
        label.fontSize = 36.0
        return label
    }()

    var successY: CGFloat {
        return size.height - 15.0
    }
    var maxY: CGFloat {
        return size.height + 16.0
    }
    var minY: CGFloat {
        return debug ? size.height * 0.65 : -17.0
    }

    var sprite: SKSpriteNode?
    var count = 0

    override init(size: CGSize) {
        super.init(size: size)
        backgroundColor = .white

        addChild(label)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addSprite() {
        self.sprite?.removeFromParent()

        let sprite = SKSpriteNode(texture: texture, size: CGSize(width: size.width, height: 32))
        addChild(sprite)
        sprite.position = CGPoint(x: size.width / 2.0, y: minY)
        sprite.alpha = 0.6

        sprite.physicsBody = SKPhysicsBody(texture: texture, size: sprite.size)
        sprite.physicsBody?.affectedByGravity = false
        sprite.physicsBody?.linearDamping = 0.0
        sprite.physicsBody?.velocity = CGVector(dx: 0.0, dy: 250.0)

        self.sprite = sprite

        count += 1
        label.text = String(count)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let sprite = sprite, count != 0 {
            guard sprite.position.y > maxY - 100.0 else { return }

            sprite.physicsBody = nil

            if sprite.position.y > successY - 2.0 && sprite.position.y < successY + 2.0 {
                let group = SKAction.group([
                    SKAction.fadeAlpha(to: 1.0, duration: 0.6),
                    SKAction.move(to: CGPoint(x: sprite.position.x, y: successY), duration: 0.6)
                ])
                sprite.run(group) {
                    self.label.text = "Clear!"
                    self.count = 0
                }
            } else {
                let action = SKAction.fadeOut(withDuration: 0.3)
                sprite.run(action) {
                    self.addSprite()
                }
            }
        } else {
            addSprite()
        }
    }

    override func didSimulatePhysics() {
        guard let sprite = sprite else { return }
        if sprite.position.y > maxY {
            addSprite()
        }
    }
}
