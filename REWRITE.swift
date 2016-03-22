import SpriteKit
import UIKit
import Foundation

var i:Int = 0
var enemy:SKSpriteNode = SKSpriteNode(imageNamed: "gargar")
var enemiesArray:[String] = []
var myScore:SKLabelNode = SKLabelNode(fontNamed:"Chalkduster")
var count = 0
var seconds = 0
var timer = SKAction()
var timerLabel:SKLabelNode = SKLabelNode(fontNamed:"Chalkduster")


class GameScene: SKScene {
    //SETUP SECONDS, COUNT, TIMERLABEL AND SCORELABEL
    func setUp() {
        seconds = 30
        count = 0
        timerLabel.text = "Time:\(seconds)"
        myScore.text = "Score:\(count)"
    }
    //INCREMENT COUNT, UPDATE SCORELABEL, PLAY SFX
    func scoreUp(){
        count++
        myScore.text = "Score\(count)"
        self.runAction(SKAction.playSoundFileNamed("chimeUp.wav",
            waitForCompletion: true))
    }
    //DECREMENT SECONDS,UPDATE SCORELABEL, PLAY SFX
    func subtractTime() {
        seconds--
        timerLabel.text = "Time:\(seconds)"
        self.runAction(SKAction.playSoundFileNamed("chimeUp.wav",
            waitForCompletion: true))
    }
    
    override func didMoveToView(view: SKView) {
        //SET BACKGROUND COLOR
        backgroundColor = SKColor.blackColor()
        //CALL SETUP FUNC
        setUp()
        //SET SCORELABEL FONTSIZE, POSITION AND ADD TO SCENE
        myScore.fontSize = 80
        myScore.position = CGPoint(x: frame.size.width / 1.8, y: frame.size.height / 3)
        self.addChild(myScore)
        //SET TIMERLABEL FONTSIZE, POSITION AND ADD TO SCENE
        timerLabel.fontSize = 80
        timerLabel.position = CGPoint(x: frame.size.width / 3, y: frame.size.height / 1.8)
        self.addChild(timerLabel)
        //HELPER FUNC1;CREATE RANDOM FLOAT
        func random() -> CGFloat {
            return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
        }
        //HELPER FUNC2; CREATE RANGE USING HELPER FUNC1
        func random2(min min: CGFloat, max: CGFloat) -> CGFloat {
            return random() * (max - min) + min
        }
        //CREATE FORLOOP, GENERATE OBJECTS; ADD OBJECTS TO ARRAY
        for (i = 0; i < 6; ++i) {
            
            func spawnEnemy() {
                
                let enemy = SKSpriteNode(imageNamed: "gargar")
                enemy.name = "enemy_\(i)"
                enemy.size = CGSize(width: 180, height: 180)
                enemy.position = CGPoint(
                    x: self.frame.size.width * random2(min: 0, max: 1),
                    y: self.frame.size.height * random2(min: 0, max: 1)
                )
                self.addChild(enemy)
                //APPEND ENEMY NAMES TO ARRAY[STRING]
                enemiesArray.append("enemy_\(i)")
            }
            runAction(SKAction.sequence([SKAction.runBlock(spawnEnemy)]))
        }
        //AFTER 30SECS, AUTOMATICALLY RETURN TO GAMESCENE
        let escapeAction = SKAction.waitForDuration(30)
        let escapeRun = SKAction.runBlock({
            
            let espSc = WinScene (size:self.size)
            espSc.scaleMode = self.scaleMode
            let reveal = SKTransition.fadeWithDuration(2)
            self.view?.presentScene(espSc, transition:reveal)
            
        })
        
        self.runAction((SKAction.sequence([escapeAction,escapeRun])))
        
            let delayAction = SKAction.waitForDuration(NSTimeInterval(1.0))
            let delayRun = SKAction.runBlock({
                print("DELAY FIRED...")
                self.subtractTime()
                SKAction.playSoundFileNamed("chimeUp.wav", waitForCompletion: false)
                
            })
            //RUNS ACTION ONLY ONCE...
            //self.runAction((SKAction.sequence([delayAction,delayRun])))
            //RUNS ACTION ONLY FOREVER...
            self.runAction(SKAction.repeatActionForever(SKAction.sequence([delayAction,delayRun])))
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            
            //CAPTURE TOUCHED POINT, SPECIFIC NODE TOUCHED
            let location = touch.locationInNode(self)
            let nodeTouched = nodeAtPoint(location)
            //ADD PARTICLES
            let spark:SKEmitterNode = SKEmitterNode(fileNamed: "Smoke")!
            //IF ON TOUCH EVALS TO ENEMY POSITION;
            //CAST AS SPRITENODE; ADD SPARKS;PLAY SOUND
            if let _ = nodeTouched as? SKSpriteNode
            {
                spark.position = nodeTouched.position
                spark.zPosition = 1
                self.addChild(spark)
                //PLAY SFX
                self.runAction(SKAction.playSoundFileNamed("explo6.wav",
                    waitForCompletion: true))
                //REMOVE NODE FROM SCENE; SUBTRACT TIME; INCREASE SCORE
                enemy.removeFromParent()
                //FAIL::TRIES TO REMOVE SOMETHING THAT IS NIL??
                //enemiesArray.removeLast()
                //subtractTime()
                scoreUp()
                print("TAPPED ON GRAPE!")
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
                //enemiesArray.removeAll()
                enemy.removeFromParent()
            }
            //ENEMIES ARRAY IS EMPTY; GO TO WINSCENE
            if enemiesArray.count == 0 {
                //ADD SCENE TRANSITION
                let newSc = GameScene (size:self.size)
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
        print("UPDATED SCENE...")
        
    }
}