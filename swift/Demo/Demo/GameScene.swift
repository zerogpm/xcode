//
//  GameScene.swift
//  Demo
//
//  Created by Jian Su on 11/28/15.
//  Copyright (c) 2015 Jian Su. All rights reserved.
//

import SpriteKit


class GameScene: SKScene {
    
    var player:SKSpriteNode = SKSpriteNode()
    
    override func didMoveToView(view: SKView) {
        
        //player = self.childNodeWithName("Player") as! SKSpriteNode
        
        if let someSpriteNode:SKSpriteNode = self.childNodeWithName("Player") as? SKSpriteNode {
            player = someSpriteNode
        } else {
            print("Cannot cast some sprite")
        }
        
        findChildNode("Player")
    }
    
    func findChildNode(Name:String) {
        self.enumerateChildNodesWithName("//*") {
            node, stop in
            
            if (node.name == Name) {
                if let someSpriteNode:SKSpriteNode = node as? SKSpriteNode {
                    stop.memory = true
                    someSpriteNode.alpha = 0.5
                } else {
                    print("Cannot cast some sprite")
                }

            }
           
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
//        for touch in touches {
//            
//        }
        
        player.alpha = player.alpha * 0.9
        
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
