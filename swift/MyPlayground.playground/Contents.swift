//: Playground - noun: a place where people can play

import UIKit
import SpriteKit
import XCPlayground

let view = SKView(frame: CGRect(x: 0, y: 0, width: 1024, height: 768))

XCPlaygroundPage.liveView("ourview", view:view)

let scene = SKScene(size: CGSize(width: 1024, height: 768))
scene.scaleMode = SKSceneScaleMode.AspectFit
view.presentScene(scene)
scene.backgroundColor = SKColor.blackColor()