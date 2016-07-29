//
//  GameScene.swift
//  Zombie
//
//  Created by Jian Su on 7/9/16.
//  Copyright (c) 2016 Jian Su. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
  
  let playableRect: CGRect
  
  let zombie = SKSpriteNode(imageNamed: "zombie1")
  var lastUpdateTime:NSTimeInterval = 0
  var dt:NSTimeInterval = 0
  
  var zombieMovePointsPerSec: CGFloat = 480.0
  let zombieRotateRadiansPerSec:CGFloat = 4.0 * π
  var velocity = CGPoint.zero
  
  var lastTouchLocation:CGPoint?
  
  override init(size:CGSize) {
    let maxAspectRatio:CGFloat = 16.0 / 9.0
    let playableHeight = size.width / maxAspectRatio
    let playableMargin = (size.height - playableHeight) / 2.0
    playableRect = CGRect(x:0,y:playableMargin,width: size.width, height: playableHeight)
    super.init(size:size)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func didMoveToView(view: SKView) {
    let background = SKSpriteNode(imageNamed: "background1")
    background.position = CGPoint(x: size.width/2, y: size.height/2)
    background.anchorPoint = CGPoint(x: 0.5, y: 0.5)//default
    background.zPosition = -1
    addChild(background)
    
    zombie.position = CGPoint(x: 400, y: 400)
    addChild(zombie)
    debugDrawPlayableArea()
  }
  
  func moveZombieToward(location:CGPoint) {
    let offset = location - zombie.position
    let direction = offset.normalized()
    velocity = direction * zombieMovePointsPerSec
  }
  
  func moveSprite(sprite:SKSpriteNode, velocity:CGPoint) {
    
    let amountToMove = velocity * CGFloat(dt)
    print("Amount to move: \(amountToMove)")
    
    sprite.position += amountToMove
  }
  
  func rotateSprite(sprite: SKSpriteNode, direction: CGPoint,
                    rotateRadiansPerSec: CGFloat) {
    let shortest = shortestAngleBetween(sprite.zRotation, angle2: velocity.angle)
    let amountToRotate = min(rotateRadiansPerSec * CGFloat(dt), abs(shortest))
    sprite.zRotation += shortest.sign() * amountToRotate
  }
  
  func boundsCheckZombie() {
    let bottomLeft = CGPoint(x: 0, y: CGRectGetMinY(playableRect))
    let topRight = CGPoint(x: size.width, y: CGRectGetMaxY(playableRect))
    
    if zombie.position.x <= bottomLeft.x {
      zombie.position.x = bottomLeft.x
      velocity.x = -velocity.x
    }
    if zombie.position.x >= topRight.x {
      zombie.position.x = topRight.x
      velocity.x = -velocity.x
    }
    if zombie.position.y <= bottomLeft.y {
      zombie.position.y = bottomLeft.y
      velocity.y = -velocity.y
    }
    if zombie.position.y >= topRight.y {
      zombie.position.y = topRight.y
      velocity.y = -velocity.y
    }
  }
  
  override func update(currentTime: NSTimeInterval) {
    if lastUpdateTime > 0 {
      dt = currentTime - lastUpdateTime
    } else {
      dt = 0
    }
    
    lastUpdateTime = currentTime
    //print("\(dt * 1000) miliseconds since last update")
    
    //moveSprite(zombie, velocity: CGPoint(x: zombieMovePointsPerSec, y: 0))
    if let lastTouchLocation = lastTouchLocation {
      let diff = lastTouchLocation - zombie.position
      if diff.length() <= zombieMovePointsPerSec * CGFloat(dt) {
        zombie.position = lastTouchLocation
        velocity = CGPointZero
      } else {
        moveSprite(zombie, velocity: velocity)
        rotateSprite(zombie, direction: velocity, rotateRadiansPerSec: zombieRotateRadiansPerSec)
      }
    }
    
    boundsCheckZombie()
  }
  
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    guard let touch = touches.first else {
      return
    }
    
    let touchLocation = touch.locationInNode(self)
    lastTouchLocation = touchLocation
    moveZombieToward(touchLocation)
  }
  
  override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
    guard let touch = touches.first else {
      return
    }
    
    let touchLocation = touch.locationInNode(self)
    lastTouchLocation = touchLocation
    moveZombieToward(touchLocation)
  }
  
  func debugDrawPlayableArea() {
    let shape = SKShapeNode()
    let path = CGPathCreateMutable()
    CGPathAddRect(path, nil, playableRect)
    shape.path = path
    shape.strokeColor = SKColor.redColor()
    shape.lineWidth = 4.0
    addChild(shape)
  }
  
  
}
