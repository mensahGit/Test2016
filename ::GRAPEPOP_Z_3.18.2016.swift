//GRAPEPOP Z
//  ButMunch.swift
//  GrapePop
//
//  Created by Mensah on 3/18/16.
//  Copyright (c) 2016 Mensah Moody. All rights reserved.
//

import SpriteKit
import UIKit
import Foundation

var i:Int = 0
var enemy:SKSpriteNode = SKSpriteNode(imageNamed: "gargar")
var enemiesArray : [String] = []
var myScore:SKLabelNode?



class GameScene: SKScene {
  
    var enemy:SKSpriteNode = SKSpriteNode(imageNamed: "gargar")
    
    override func didMoveToView(view: SKView) {
        
        myScore = SKLabelNode(fontNamed:"Chalkduster")
        myScore!.text = "000"
        myScore!.fontSize = 80
        myScore!.position = CGPoint(x: frame.size.width / 1.8, y: frame.size.height / 3)
        self.addChild(myScore!)
        
        
        func random() -> CGFloat {
            return CGFloat(Float(arc4random()) / 0xFFFFFFFF) }
        
        func random2(min min: CGFloat, max: CGFloat) -> CGFloat {
            return random() * (max - min) + min }
        
        backgroundColor = SKColor.blackColor()
        
        
        for (i = 1; i < 6; ++i) {
            /* Setup your scene here */
            
            print("fired \(i)")
            
            func spawnEnemy() {
                let enemy = SKSpriteNode(imageNamed: "gargar")
                enemy.name = "enemy_\(i)"
                enemy.size = CGSize(width: 180, height: 180)
                enemy.position = CGPoint(x: frame.size.width * random2(min: 0, max: 1), y: frame.size.height * random2(min: 0, max: 1))
                self.addChild(enemy)
                //print("this is our enemy: \(enemy.name)")
                
                enemiesArray.append("enemy")
                print("enemy_\(i)\(enemiesArray.count)")
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
                       print("LOCATION TOUCHED: \(location)")
                       print("NODE TOUCHED: \(nodeTouched)")
                       print("ENEMY ARRAY COUNT: \(enemiesArray.count)")
                    print("ENEMY OF TYPE: \(enemy.dynamicType)")
            //
            //            for (index, value) in enemiesArray.enumerate() {
            //                print("Enemies \(index + 1): \(value)")
            //            }

            
            
            //select child to remove by name
            if enemy.name == nil {
                //enemy.name = ""
            //enemy = (self.childNodeWithName("enemy_\(i)") as! SKSpriteNode)
            }
            
            print("CLASS OF NODE TOUCHED: \(nodeTouched.dynamicType)")
                
            
            
            print("NAME OF ENEMY: enemy_\(i)")
            
            
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
                
                //self.childNodeWithName("enemy_\(i)\(enemiesArray.count)")
                enemy.removeFromParent()
                enemiesArray.removeLast()
                print("TAPPED ON GRAPE!")
                
                myScore!.text = "\(enemiesArray.count)"
            }
            if nodeTouched.name == "enemy_\(i)" {
                //FAIL!: enemy.position = nodeTouched.position
                nodeTouched.position = enemy.position
                
                enemy.removeFromParent()
                print("CHAO, GRAPE!")
            }
            //&& !intersectsNode(enemy)
            if nodeTouched.name != "enemy_\(i)" && enemiesArray.isEmpty {
                print("NOTHING LEFT TO POP!")
                enemiesArray.removeAll()
                enemy.removeFromParent()
            }
            if enemiesArray.count == 0 {
                //ADD SCENE TRANSITION
                let newSc = WinScene (size:self.size)
                newSc.scaleMode = scaleMode
                let reveal = SKTransition.fadeWithDuration(2)
                self.view?.presentScene(newSc, transition:reveal)
            }
                
            else {
                print("EMPTY SPACE TAPPED!")
                print("ENEMY ARRAY COUNT: \(enemiesArray.count)")
                

            }
//            if enemiesArray.count == 0 {
//                //ADD SCENE TRANSITION
//                let newSc = GameScene (size:self.size)
//                newSc.scaleMode = scaleMode
//                let reveal = SKTransition.fadeWithDuration(1)
//                self.view?.presentScene(newSc, transition:reveal)
//            }

        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
    }
}