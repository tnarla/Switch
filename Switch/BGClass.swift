//
//  BGClass.swift
//  Switch
//
//  Created by Trushitha Narla on 6/28/17.
//  Copyright © 2017 chicken squid. All rights reserved.
//

import SpriteKit

class BGClass: SKSpriteNode {
    
    func moveBG(camera: SKCameraNode) {
        if self.position.x + self.size.width < camera.position.x {
            self.position.x += self.size.width * 3
        }
        
    }
    
    func initializeGround() {
        physicsBody = SKPhysicsBody(rectangleOf: self.size)
        physicsBody?.affectedByGravity = false
        physicsBody?.isDynamic = false
        physicsBody?.categoryBitMask = ColliderType.GROUND
    }
    
}
