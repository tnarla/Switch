//
//  GameScene.swift
//  Switch
//
//  Created by Trushitha Narla on 6/28/17.
//  Copyright © 2017 chicken squid. All rights reserved.
//

import UIKit
import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    private var ground: BGClass?
    private var ceiling: BGClass?
    
    private var mainCamera: SKCameraNode?
    
    private var player: Player?
    
    private var itemController = ItemController()
    private var itemsSpawned = [SKSpriteNode]()
    
    private var scoreLabel: SKLabelNode?
    private var score = 0
    
    private var startTime : DispatchTime?
    private var moveFactor: CGFloat = 0.5
    private var maxMoveFactor: CGFloat = 7
    
    override func didMove(to view: SKView) {
        initializeGame()
        manageEnvironment()
    }
    
    override func update(_ currentTime: TimeInterval) {
        manageEnvironment()
        for item in itemsSpawned {
            item.position.x -= 3 + moveFactor
        }
        
        if (Int(currentTime.truncatingRemainder(dividingBy: 5)) == 0) {
            if moveFactor < maxMoveFactor {
                moveFactor *= 1.005
            }
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        reverseGravity()
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        startTime = DispatchTime.now()
        
        var firstBody = SKPhysicsBody();
        var secondBody = SKPhysicsBody();
        
        if contact.bodyA.node?.name == "Player" {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if firstBody.node?.name == "Player" && secondBody.node?.name == "Coin" {
           score += 1
            scoreLabel?.text = String(score)
            secondBody.node?.removeFromParent()
        } else if firstBody.node?.name == "Player" && secondBody.node?.name == "Spike" {
            firstBody.node?.removeFromParent()
            Timer.scheduledTimer(timeInterval: TimeInterval(1), target: self, selector: #selector(GameScene.restartGame), userInfo: nil, repeats: false)
        }
    }
    
    private func spawnBackgroundParticles() {
        let frame  = CGRect(x: 0, y: 0, width: 720 , height: 2560)
        
        let emitter = SKEmitterNode()
        emitter.particleLifetime = 80
        emitter.particleBlendMode = SKBlendMode.alpha
        emitter.particleBirthRate = 4
        emitter.particleSize = CGSize(width: 6,height: 6)
        emitter.particleColor = SKColor(red: 100, green: 100, blue: 255, alpha: 1)
        emitter.position = CGPoint(x:frame.size.width,y:0)
        emitter.particleSpeed = 50
        emitter.particleSpeedRange = 40
        emitter.particlePositionRange = CGVector(dx: 0, dy: frame.size.height)
        emitter.emissionAngle = 3.14
        emitter.advanceSimulationTime(80)
        emitter.particleAlpha = 0.5
        emitter.particleAlphaRange = 0.3
        emitter.zPosition = 0
        self.addChild(emitter)
        
        let pinkEmitter = SKEmitterNode()
        pinkEmitter.particleLifetime = 80
        pinkEmitter.particleBlendMode = SKBlendMode.alpha
        pinkEmitter.particleBirthRate = 2
        pinkEmitter.particleSize = CGSize(width: 4,height: 4)
        pinkEmitter.particleColor = SKColor(red:0.2, green:0.53, blue:0.97, alpha: 1)
        pinkEmitter.position = CGPoint(x:frame.size.width,y:0)
        pinkEmitter.particleSpeed = 30
        pinkEmitter.particleSpeedRange = 20
        pinkEmitter.particlePositionRange = CGVector(dx: 0, dy: frame.size.height)
        pinkEmitter.emissionAngle = 3.14
        pinkEmitter.advanceSimulationTime(80)
        pinkEmitter.particleAlpha = 0.3
        pinkEmitter.particleAlphaRange = 0.2
        pinkEmitter.zPosition = 1
        self.addChild(pinkEmitter)

    }
    
    private func initializeGame () {
        physicsWorld.contactDelegate = self
        spawnBackgroundParticles()
        
        mainCamera = childNode(withName: "MainCamera") as? SKCameraNode!
        ground = childNode(withName: "ground") as? BGClass!
        ceiling = childNode(withName: "ceiling") as? BGClass!
        
        ground?.initializeGround()
        ceiling?.initializeGround()
        
        player = childNode(withName: "Player") as? Player!
        player?.initializePlayer()
        
        scoreLabel = childNode(withName: "Score") as? SKLabelNode!
        scoreLabel?.text = String(score)
        
        Timer.scheduledTimer(timeInterval: TimeInterval(itemController.randomBetweenNumbers(first: 2, second: 5)), target: self, selector: #selector(GameScene.spawnItems), userInfo: nil, repeats: true)
        
        Timer.scheduledTimer(timeInterval: TimeInterval(itemController.randomBetweenNumbers(first: 4, second: 14)), target: self, selector: #selector(GameScene.spawnGroundSpikes), userInfo: nil, repeats: true)
        
        
        Timer.scheduledTimer(timeInterval: TimeInterval(itemController.randomBetweenNumbers(first: 6, second: 17)), target: self, selector: #selector(GameScene.spawnCeilingSpikes), userInfo: nil, repeats: true)
        
        
    }
    
    private func manageEnvironment () {
        for item in itemsSpawned {
            if item.position.x < (self.mainCamera!.position.x - self.scene!.frame.width / 1.5) {
                item.removeFromParent()
            }
        }
    }
    
    private func reverseGravity () {
        physicsWorld.gravity.dy *= -1
        player?.reversePlayer()
    }
    
    func spawnItems() {
        let tempItem = itemController.spawnItems(camera: mainCamera!)
        self.scene?.addChild(tempItem)
        itemsSpawned.append(tempItem)
    }
    
    func spawnGroundSpikes() {
        let tempItem = itemController.spawnGroundSpikes(camera: mainCamera!)
        self.scene?.addChild(tempItem)
        itemsSpawned.append(tempItem)
    }
    
    func spawnCeilingSpikes() {
        let tempItem = itemController.spawnCeilingSpikes(camera: mainCamera!)
        self.scene?.addChild(tempItem)
        itemsSpawned.append(tempItem)
    }
    
    // change later
    // the emitter is not working as well
    func restartGame () {
        if let scene = GameScene(fileNamed: "GameScene") {
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            
            view!.presentScene(scene, transition: SKTransition.fade(withDuration: 1))
        }
    }
}
