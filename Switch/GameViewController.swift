//
//  GameViewController.swift
//  Switch
//
//  Created by Trushitha Narla on 6/27/17.
//  Copyright © 2017 chicken squid. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = GameScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                view.presentScene(scene)
                
                //scene.run(SKAction.playSoundFileNamed("song.mp3", waitForCompletion: false))
                
            }
            
            view.ignoresSiblingOrder = false
            //view.showsPhysics = true
            view.showsFPS = true
            view.showsNodeCount = true
            
        }
    }
    

    override var shouldAutorotate: Bool {
        return false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
