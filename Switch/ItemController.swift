//
//  ItemController.swift
//  Switch
//
//  Created by Trushitha Narla on 6/29/17.
//  Copyright © 2017 chicken squid. All rights reserved.
//

import SpriteKit

class ItemController {
    
    private var minY = CGFloat(-216), maxY = CGFloat(265)
    
    private var spikeGround = CGFloat(-222.8)
    private var spikeCeiling = CGFloat(272.8)
    
    func spawnItems(camera: SKCameraNode) -> SKSpriteNode {
        let item: SKSpriteNode?
        item = SKSpriteNode(imageNamed: "SwitchItem1")
        item?.name = "Coin"
        item?.setScale(0.25)
        item?.physicsBody = SKPhysicsBody(circleOfRadius: item!.size.height/2)
        
        item!.physicsBody?.affectedByGravity = false;
        item?.physicsBody?.categoryBitMask = ColliderType.ENEMY_COINS
        
        item?.zPosition = 4;
        item?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        item?.position.x = camera.position.x + 900
        item?.position.y = randomBetweenNumbers(first: minY, second: maxY)
        return item!
    }
    
    func spawnGroundSpikes(camera: SKCameraNode) -> SKSpriteNode {
        let spike: SKSpriteNode?
        spike = SKSpriteNode(imageNamed: "SwitchObstacleGroundSpikes")
        spike?.name = "Spike"
        spike?.setScale(0.4)
        spike?.anchorPoint = CGPoint(x: 0.5, y:0.5)
        spike?.physicsBody = SKPhysicsBody(rectangleOf: (spike?.size)!, center: (spike?.anchorPoint)!)
        spike!.physicsBody?.affectedByGravity = false;
        spike?.physicsBody?.categoryBitMask = ColliderType.ENEMY_COINS
        
        spike?.position.x = camera.position.x + 1300
        spike?.position.y = spikeGround
        
        return spike!

    }
    
    func spawnCeilingSpikes(camera: SKCameraNode) -> SKSpriteNode {
        let spike: SKSpriteNode?
        spike = SKSpriteNode(imageNamed: "SwitchObstacleGroundSpikes")
        spike?.name = "Spike"
        spike?.setScale(0.4)
        spike?.zRotation = CGFloat(Double.pi)
        spike?.anchorPoint = CGPoint(x: 0.5, y:0.5)
        spike?.physicsBody = SKPhysicsBody(rectangleOf: (spike?.size)!, center: (spike?.anchorPoint)!)
        spike!.physicsBody?.affectedByGravity = false;
        spike?.physicsBody?.categoryBitMask = ColliderType.ENEMY_COINS
        
        spike?.position.x = camera.position.x + 1500
        spike?.position.y = spikeCeiling
        return spike!
        
    }
    
    func randomBetweenNumbers(first: CGFloat, second: CGFloat) -> CGFloat {
        
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs (first - second) + min(first, second)
    }
}
