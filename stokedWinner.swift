//GRAPEPOP Z
//  ButMunch.swift
//  GrapePop
//
//  Created by Mensah on 3/16/16.
//  Copyright (c) 2016 Mensah Moody. All rights reserved.
//

import SpriteKit
import UIKit
import Foundation

var i:Int = 0

var enemy:SKSpriteNode = SKSpriteNode(imageNamed: "gargar")
var enemiesArray : [AnyObject] = []


class GameScene: SKScene {
    
    
    override func didMoveToView(view: SKView) {
        
        func random() -> CGFloat {
            return CGFloat(Float(arc4random()) / 0xFFFFFFFF) }
        
        func random2(min min: CGFloat, max: CGFloat) -> CGFloat {
            return random() * (max - min) + min }
        
        backgroundColor = SKColor.blackColor()
        
        
        for (i = 1; i < 50; ++i) {
            /* Setup your scene here */
            
            print("fired \(i)")
            
            func spawnEnemy() {
                let enemy = SKSpriteNode(imageNamed: "gargar")
                enemy.name = "enemy \(i)"
                enemy.size = CGSize(width: 80, height: 80)
                enemy.position = CGPoint(x: frame.size.width * random2(min: 0, max: 1), y: frame.size.height * random2(min: 0, max: 1))
                self.addChild(enemy)
                //print("this is our enemy: \(enemy.name)")
                
                enemiesArray.append("enemy")
                print("enemy \(i)\(enemiesArray.count)")
            }
            runAction(SKAction.sequence([SKAction.runBlock(spawnEnemy)]))
        }
        
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        for touch in touches {
            
            let location = touch.locationInNode(self)
            let nodeTouched = nodeAtPoint(location)
            //           output location touched + enemy name and value
                       print("location touched \(location)")
                       print("node touched \(nodeTouched)")
                       print("enemy name and value: \(enemiesArray.count)")
            //
            //            for (index, value) in enemiesArray.enumerate() {
            //                print("Enemies \(index + 1): \(value)")
            //            }
            
            //select child to remove by name
            enemy = (self.childNodeWithName("enemy \(i)") as! SKSpriteNode)
            print("enemy \(i)")
            
            //add particles
            //let spark:SKEmitterNode = SKEmitterNode(fileNamed: "Fire")!
            //spark.position = enemy.position
            //spark.zPosition = 1
            //self.addChild(spark)
            
            //add particles
            let spark:SKEmitterNode = SKEmitterNode(fileNamed: "Fire")!
            
            //if on touch equals enemy position, then play audio; else nil action
            //if location == enemy.position && enemy.containsPoint(enemy.position)//needs to be cast as SKSprite for sparks to show
            if let _ = nodeTouched as? SKSpriteNode
                {
                spark.position = nodeTouched.position//previously[enemy.position]
                spark.zPosition = 1
                self.addChild(spark)
                
                self.runAction(SKAction.playSoundFileNamed("explo6.wav", waitForCompletion: true))
                print("Tapped on a grape!")
                //enemy.removeFromParent()
                self.childNodeWithName("enemy \(i)\(enemiesArray.count)")
                
            }
            if nodeTouched.name == "enemy \(i)" {
                //FAIL!: enemy.position = nodeTouched.position
                nodeTouched.position = enemy.position
                print("My man!")
                enemy.removeFromParent()
            }
            if nodeTouched.name != "enemy \(i)" && !intersectsNode(enemy) {
                print("Nothing to tap!")
            }
            else {
                print("Tapped on empty space!")
            }

        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
    }
}