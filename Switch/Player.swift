//
//  Player.swift
//  Switch
//
//  Created by Trushitha Narla on 6/28/17.
//  Copyright © 2017 chicken squid. All rights reserved.
//

import SpriteKit

struct ColliderType {
    static let PLAYER: UInt32 = 0
    static let GROUND: UInt32 = 1
    static let ENEMY_COINS: UInt32 = 2
}

struct Rotations {
    static var player_rotation: CGFloat = 0
}

class Player: SKSpriteNode {
    
    func initializePlayer () {
        physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width, height: self.size.height))
        
        physicsBody?.affectedByGravity = true
        physicsBody?.restitution = 0
        physicsBody?.allowsRotation = false
        physicsBody?.categoryBitMask = ColliderType.PLAYER
        physicsBody?.collisionBitMask = ColliderType.GROUND
        physicsBody?.contactTestBitMask = ColliderType.ENEMY_COINS
        
    }
    
    func reversePlayer() {
        // rotate Player instead so it looks like grav is changing.
        //self.yScale *= -1
    }


}
