//
//  GameViewController.swift
//  ChippyGame
//  newforme
//
//  Created by Macbook Air on 10/24/19.
//  Copyright © 2019 Lambton. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
 
    
        if let view = self.view as! SKView? {
          
            if let scene = SKScene(fileNamed: "GameScene") {
                
                scene.scaleMode = .aspectFill
                
           
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
        
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
