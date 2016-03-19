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

var vc:UIViewController!

var i:Int = 0
var enemy:SKSpriteNode = SKSpriteNode(imageNamed: "gargar")
var enemiesArray : [String] = []
var myScore:SKLabelNode = SKLabelNode(fontNamed:"Chalkduster")
var count = 0
var seconds = 0
var timer = SKAction()
var timerLabel:SKLabelNode = SKLabelNode(fontNamed:"Chalkduster")

//var backgroundMusic : AVAudioPlayer?


class GameScene: SKScene {

    func setUp() {
        seconds = 30
        count = 0
        timerLabel.text = "Time:\(seconds)"
        myScore.text = "Score:\(count)"
        //backgroundMusic?.volume = 0.3
        //backgroundMusic?.play()
    }

    func scoreUp() {
        count++
        myScore.text = "Score\(count)"
        self.runAction(SKAction.playSoundFileNamed("chimeUp.wav", waitForCompletion: true))
    }

    func subtractTime() {
        seconds--
        timerLabel.text = "Time:\(seconds)"
        self.runAction(SKAction.playSoundFileNamed("chimeUp.wav", waitForCompletion: true))
    }

    
    
override func didMoveToView(view: SKView) {
        
        setUp()
        
        myScore = SKLabelNode(fontNamed:"Chalkduster")
        //myScore.text = "000"
        myScore.fontSize = 80
        myScore.position = CGPoint(x: frame.size.width / 1.8, y: frame.size.height / 3)
        self.addChild(myScore)
        
        timerLabel = SKLabelNode(fontNamed:"Chalkduster")
        timerLabel.text = ":00"
        timerLabel.fontSize = 80
        timerLabel.position = CGPoint(x: frame.size.width / 3, y: frame.size.height / 1.8)
        self.addChild(timerLabel)
        
        
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
        
//FIXME: --
        let actionwait = SKAction.waitForDuration(3)
        //var timesecond = Int()
        let actionrun = SKAction.runBlock({
            //count++
            //seconds++
            if seconds == 30 {seconds = 0}
            myScore.text = "Score Time: \(timerLabel):\(seconds)"
        })
        
        myScore.runAction(SKAction.repeatActionForever(SKAction.sequence([actionwait,actionrun])))
        
}
    
override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    
        for touch in touches {
            
            let location = touch.locationInNode(self)
            let nodeTouched = nodeAtPoint(location)
            //output location touched + enemy name and value
                       print("LOCATION TOUCHED: \(location)")
                       print("NODE TOUCHED: \(nodeTouched)")
                       print("ENEMY ARRAY COUNT: \(enemiesArray.count)")
                       print("ENEMY OF TYPE: \(enemy.dynamicType)")
            
            print("CLASS OF NODE TOUCHED: \(nodeTouched.dynamicType)")
                
            print("NAME OF ENEMY: enemy_\(i)")
            
            //ADD PARTICLES
            let spark:SKEmitterNode = SKEmitterNode(fileNamed: "Fire")!
            //IF ON TOUCH EVALS TO ENEMY POSITION; CAST AS SPRITENODE; ADD SPARKS;PLAY SOUND;
            REMOVE ENEMY; REMOVE FROM ARRAY; SUBTRACT TIME; INCREASE SCORE
            //if on touch equals enemy position, then play audio; else nil action
            //if location == enemy.position && enemy.containsPoint(enemy.position)//needs to be cast as SKSprite for sparks to show
            if let _ = nodeTouched as? SKSpriteNode
                {
                spark.position = nodeTouched.position//previously[enemy.position]
                spark.zPosition = 1
                self.addChild(spark)
                
                self.runAction(SKAction.playSoundFileNamed("explo6.wav", waitForCompletion: true))
                
                enemy.removeFromParent()
                enemiesArray.removeLast()
                subtractTime()
                scoreUp()
                print("TAPPED ON GRAPE!")
                //myScore.text = "\(enemiesArray.count)"
            }
            //IF TOUCHED NODE NAME EVALS TO ENEMY NAME; REMOVE THAT ENEMY
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
            //ENEMIES ARRAY IS EMPTY; GO TO WINSCENE
            if enemiesArray.count == 0 {
                //ADD SCENE TRANSITION
                let newSc = WinScene (size:self.size)
                newSc.scaleMode = scaleMode
                let reveal = SKTransition.fadeWithDuration(2)
                self.view?.presentScene(newSc, transition:reveal)
            }
            //TAPPED ON EMPTY SPACE
            else {
                print("EMPTY SPACE TAPPED!")
                print("ENEMY ARRAY COUNT: \(enemiesArray.count)")
            }
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        
        }
}