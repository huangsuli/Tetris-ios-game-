//
//  GameViewController.swift
//  tetris
//
//  Created by Suli Huang on 3/26/16.
//  Copyright (c) 2016 Suli Huang. All rights reserved.
//

import UIKit
import SpriteKit

var scene: GameScene!

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let skView = view as! SKView
        skView.multipleTouchEnabled = false;
        
        scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = .AspectFill
        
        skView.presentScene(scene)

    }

    

   
   
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
