//
//  GameScene.swift
//  ChippyGame
//  newforme
//
//  Created by Macbook Air on 10/24/19.
//  Copyright © 2019 Lambton. All rights reserved.
//
import SpriteKit
import GameplayKit

class GameScene: SKScene,SKPhysicsContactDelegate {
   
    
    
    
    
    /**
 
     var player:Player = Player(imageNamed: "player")
     var enemy:Enemy = Enemy(imageNamed: "chippyenemy")
     //var playerBullet: SKSpriteNode!
     var playerBullet:Bullet = Bullet(imageNamed: "playerbullet")
     var enemyBullet:Bullet = Bullet(imageNamed: "enemyBullet")
     //var screenBorder:SKSpriteNode!
     var bulletsArray:[SKSpriteNode] = []
     var upArrow:SKSpriteNode!
     var downArrow:SKSpriteNode!
     var leftArrow:SKSpriteNode!
     var rightArrow:SKSpriteNode!
     var upLeftArrow:SKSpriteNode!
     var downLeftArrow:SKSpriteNode!
     var upRightArrow:SKSpriteNode!
     var downRightArrow:SKSpriteNode!
     var arrowTouched:String = ""
     var touch:UITouch!
     var isTouched:Bool = false
     var mouseX:CGFloat! = 100
     var mouseY:CGFloat! = 100
 
 **/
    
    
    
    
    
    var ChippyhealthBar:SKShapeNode!
    var monster:SKSpriteNode!
    var eyeCore:SKSpriteNode!
    
    var topBtn:SKLabelNode!
    var bottomBtn:SKLabelNode!
    var leftBtn:SKLabelNode!
    var rightBtn:SKLabelNode!

    var healthPowerup:SKSpriteNode!
 
    var RestartButton:SKSpriteNode!
    
    

    var chippy:SKSpriteNode!
    var chippyBullet:Bullet = Bullet(imageNamed: "chippyBullet")
    var monsterBullet:Bullet = Bullet(imageNamed: "monsterBullet1")
 
    var corePresent:Bool = true
    var monsterPartsCount = 0
    var bulletsArray:[SKSpriteNode] = []
    var monsterBulletsArray:[SKSpriteNode] = []
    var moveDirection:String = ""
    var touch:UITouch!
    var mouseXPos:CGFloat!
    var mouseYPos:CGFloat!
    var spawnBullet = "no"
    var counter = 0

    
    override func didMove(to view: SKView) {
        //  Delegate  contact  with Physics
        self.physicsWorld.contactDelegate = self
   
        print("screen: \(self.size.width), \(self.size.height)")
        
        self.chippy = scene?.childNode(withName: "chippy") as! SKSpriteNode
        
        // Health Bar
        self.ChippyhealthBar = self.scene?.childNode(withName: "chippyHealthBar") as! SKShapeNode
        
        // Movement of enemy
        let monsterMove1 = SKAction.moveBy(x: 60, y: 0, duration: 0.5)
        let monsterMove2 = SKAction.moveBy(x: -60, y: 0, duration: 0.5)
        let monsterMove3 = SKAction.moveBy(x: 0, y: 60, duration: 0.5)
        let monsterMove4 = SKAction.moveBy(x: 0, y: -60, duration: 0.5)
        let monsterMoveSequence = SKAction.sequence([monsterMove1,monsterMove2, monsterMove3, monsterMove4])
        
        // Getting Core from Scene file
        self.eyeCore = self.scene?.childNode(withName: "eyeCore") as! SKSpriteNode
        
        
        self.eyeCore.run(SKAction.repeatForever(monsterMoveSequence))
        // Monster Nodes from Scene file
        
        self.enumerateChildNodes(withName: "monster") {
            (node, stop) in
            self.monster = node as? SKSpriteNode
            self.monster.run(SKAction.repeatForever(monsterMoveSequence))
            self.monsterPartsCount = self.monsterPartsCount + 1
        }
        
         self.leftBtn = scene?.childNode(withName: "left") as! SKLabelNode
         self.rightBtn = scene?.childNode(withName: "right") as! SKLabelNode
         self.topBtn = scene?.childNode(withName: "top") as! SKLabelNode
         self.bottomBtn = scene?.childNode(withName: "bottom") as! SKLabelNode
        
    }
    
    /**
 
     
     override func didMove(to view: SKView) {
     // Set the background color of the app
     gameBackgroundMusic = SKAudioNode(fileNamed:"song2.mp3")
     //  addChild(gameBackgroundMusic)
     self.backgroundColor = SKColor.black;
     let background = SKSpriteNode(imageNamed: "background")
     background.size = self.size
     background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
     background.zPosition = -1
     addChild(background)
     print("screen: \(self.size.width), \(self.size.height)")
     
     
     self.player = Player(imageNamed: "player")
     self.player.size.width = self.size.width/10
     self.player.size.height = self.size.height/7
     self.player.position = CGPoint(x: self.size.width*0.2, y: self.size.height / 2)
     player.physicsBody = SKPhysicsBody(rectangleOf: self.player.size)
     player.physicsBody?.affectedByGravity = false
     
     addChild(self.player)
     
     self.enemy = Enemy(imageNamed: "chippyenemy")
     self.enemy.size.width = self.size.width * 0.25
     self.enemy.size.height = self.size.height * 0.4
     self.enemy.position = CGPoint(x: self.size.width / 2 + self.enemy.size.width*0.5, y: self.size.height/2)
     enemy.physicsBody = SKPhysicsBody(rectangleOf: self.enemy.size)
     enemy.physicsBody?.affectedByGravity = false
     addChild(self.enemy)
     
     self.leftArrow = SKSpriteNode(imageNamed: "left")
     self.leftArrow.size = CGSize(width: self.size.width/25, height: self.size.height/20)
     self.leftArrow.position = CGPoint(x: 100, y: 250)
     addChild(self.leftArrow)
     
     self.downArrow = SKSpriteNode(imageNamed: "down")
     self.downArrow.size = CGSize(width: self.size.height/20 , height: self.size.width/30)
     self.downArrow.position = CGPoint(x: self.leftArrow.position.x + self.leftArrow.size.width*1.5, y: self.leftArrow.position.y - self.leftArrow.size.height*1.5)
     addChild(self.downArrow)
     
     self.rightArrow = SKSpriteNode(imageNamed: "right")
     self.rightArrow.size = CGSize(width: self.size.width/25, height: self.size.height/20)
     self.rightArrow.position = CGPoint(x: self.downArrow.position.x + self.leftArrow.size.width*1.5, y: self.leftArrow.position.y)
     addChild(self.rightArrow)
     
     self.upArrow = SKSpriteNode(imageNamed: "up")
     self.upArrow.size = CGSize(width: self.size.height/20, height: self.size.width/30)
     self.upArrow.position = CGPoint(x: self.downArrow.position.x, y: self.leftArrow.position.y + self.leftArrow.size.height*1.5)
     addChild(self.upArrow)
     
     self.upLeftArrow = SKSpriteNode(imageNamed: "upleft")
     self.upLeftArrow.size = CGSize(width: self.size.height/20, height: self.size.width/30)
     self.upLeftArrow.position = CGPoint(x: self.leftArrow.position.x + self.leftArrow.size.width*0.7, y: self.upArrow.position.y - self.upArrow.size.height*0.7)
     addChild(self.upLeftArrow)
     
     self.downLeftArrow = SKSpriteNode(imageNamed: "downleft")
     self.downLeftArrow.size = CGSize(width: self.size.height/20, height: self.size.width/30)
     self.downLeftArrow.position = CGPoint(x: self.upLeftArrow.position.x, y: self.downArrow.position.y + self.downArrow.size.height*0.7)
     addChild(self.downLeftArrow)
     
     self.downRightArrow = SKSpriteNode(imageNamed: "downright")
     self.downRightArrow.size = CGSize(width: self.size.height/20, height: self.size.width/30)
     self.downRightArrow.position = CGPoint(x: self.rightArrow.position.x - self.rightArrow.size.width*0.7, y: self.downLeftArrow.position.y)
     addChild(self.downRightArrow)
     
     self.upRightArrow = SKSpriteNode(imageNamed: "upright")
     self.upRightArrow.size = CGSize(width: self.size.height/20, height: self.size.width/30)
     self.upRightArrow.position = CGPoint(x: self.downRightArrow.position.x, y: self.upLeftArrow.position.y)
     addChild(self.upRightArrow)
     
     
     let move1 = SKAction.move(to: CGPoint(x: size.width/2 , y: 20),
     duration: 20)
     let move2 = SKAction.move(to:CGPoint(x:300, y:300), duration:20)
     let move3 = SKAction.move(to:CGPoint(x:300, y:20), duration:20)
     let move4 = SKAction.move(to:CGPoint(x:size.width - 300, y:400), duration:20)
     
     let grandmaAnimation = SKAction.sequence(
     [move1,move2, move3, move4]
     )
     //        let zombieAnimation = SKAction.sequence(
     //            [move3, move4]
     //        )
     
     // make gramma move in this pattern forever
     let grandmaForeverAnimation = SKAction.repeatForever(grandmaAnimation)
     self.enemy.run(grandmaForeverAnimation)
     
     
     
     if (self.player.frame.intersects(self.enemy.frame) == true) {
     //  print("\(currentTime): COLLISON!")
     //  self.lives = self.lives - 1
     
     // update the life counter
     //   self.livesLabel.text = "Lives Remaining: \(lives)"
     
     // SHOW LOSE SCREEN
     let loseScene = LoseScreen(size: self.size)
     //let transitionEffect = SKTransition.flipHorizontal(withDuration: 2)
     self.view?.presentScene(loseScene)
     //self.view?.presentScene(loseScene, transition:transitionEffect)
     
     
     
     }
 
 
 
 **/
    
    
    var bulletPattern = 2
    override func update(_ currentTime: TimeInterval) {
  
            self.movingchippy()
        
        //Check whether chippy shoot new bullets or not
        if self.spawnBullet == "yes"{
            self.spawnchippyBullet()
        }
        if (self.counter % 200 == 0){
            self.showHealthPowerup()
        }
        if (counter%150 == 0){
            self.spawnEnemyBullet()
        }
        
        //remove bullets after they hit edges or chippy/monster
        self.removeChippyBullet()
        self.rmvMonster()
        self.rmvMonsterBullet()
        
        self.counter = self.counter + 1
  
         self.gameStopped()
        //remove health powerup after it hit edges
        self.removeHealthSprite()
    }
    
    
    func spawnchippyBullet() {
        // Making bullet
        if(self.bulletsArray.count <= 1){
            self.chippyBullet = Bullet(imageNamed: "chippyBullet")
            self.chippyBullet.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "chippyBullet"), size: self.chippyBullet.size)
            self.chippyBullet.physicsBody?.categoryBitMask = 16
            self.chippyBullet.size.width = self.chippy.size.width/2
            self.chippyBullet.size.height = self.chippy.size.height/2
            self.chippyBullet.physicsBody?.affectedByGravity = false
            self.chippyBullet.position = CGPoint(x: self.chippy.position.x - 30, y: self.chippy.position.y)
            addChild(self.chippyBullet)
            self.chippyBullet.physicsBody?.collisionBitMask = 0
            self.bulletsArray.append(self.chippyBullet)

            
            // Movement of  chippy bullet towards the mouse's position
            let a = (self.mouseXPos - self.chippy.position.x);
            let b = (self.mouseYPos - self.chippy.position.y);
            
            let bulletAction = SKAction.applyImpulse(CGVector(dx: a , dy: b), duration: 0.1)
            self.chippyBullet.run(bulletAction)
        }
    }
    
    func spawnEnemyBullet(){
            if (self.bulletPattern == 1){
                // Bullets move in circular Pattern
                for i in stride(from: 0.1, to:2*CDouble.pi, by: 0.7){
                    self.monsterBullet = Bullet(imageNamed: "monsterBullet1")
                     self.monsterBullet.physicsBody = SKPhysicsBody(circleOfRadius: self.monsterBullet.size.width/2)
                    self.monsterBullet.name = "monsterBullet"
                    self.monsterBullet.physicsBody?.categoryBitMask = 4
                    self.monsterBullet.position = self.eyeCore.position
                    self.monsterBullet.physicsBody?.collisionBitMask = 0
                    addChild(self.monsterBullet)
                    self.monsterBulletsArray.append(self.monsterBullet)
                    let a = 90*cos(i) + 405
                    let b = 90*sin(i) + 780
                    let monsterBulletAction = SKAction.applyImpulse(
                        CGVector(dx: CDouble(a - 405), dy: CDouble(b - 780)),duration: 10)
                    self.monsterBullet.run(monsterBulletAction)
                }
            }
            if(self.bulletPattern == 2){
                //Chippy pattren target
                var duration = 50
                    for i in 1...7{
                    self.monsterBullet = Bullet(imageNamed: "monsterBullet2")
                    self.monsterBullet.physicsBody = SKPhysicsBody(circleOfRadius: self.monsterBullet.size.width/2)
                    self.monsterBullet.name = "monsterBullet"
                    self.monsterBullet.physicsBody?.categoryBitMask = 4
                    self.monsterBullet.position = self.eyeCore.position
                    
                    self.monsterBullet.physicsBody?.collisionBitMask = 0
                    addChild(self.monsterBullet)
                    self.monsterBulletsArray.append(self.monsterBullet)
                    
                    let x =  Float(self.chippy.position.x)
                    let y =  Float(self.chippy.position.y)
                    //moving bullet towards chippy
                    let monsterBulletAction = SKAction.applyImpulse(
                        CGVector(dx: CDouble(x - 405), dy: CDouble(y - 780)),duration: TimeInterval(duration))
                    self.monsterBullet.run(monsterBulletAction)
                    duration = duration + 20
                    
                }

            }
                if (self.bulletPattern == 1){
                    self.bulletPattern = 2
                }
            
                else if (self.bulletPattern == 2){
                    self.bulletPattern = 1
                }
            
            // play a sound when monster shoots bullets in any pattern
            let monsterbulletSound = SKAction.playSoundFileNamed("monsterBullet", waitForCompletion: true)
            run(monsterbulletSound)
    }
    
    func rmvMonsterBullet(){
        // Get all monster's Bullets
        self.monsterBullet.name = "monsterBullet"
        self.enumerateChildNodes(withName: "monsterBullet") {
            node, stop in
            if(self.monsterBulletsArray.count != 0){
                if (node is SKSpriteNode) {
                    let sprite = node as! SKSpriteNode
                    //Remove monster's bullets after they hit the borders
                    if (sprite.position.x < 10 || sprite.position.x > self.size.width - 10 || sprite.position.y < 10 || sprite.position.y > self.size.height - 10) {
                        sprite.removeFromParent()
                        self.monsterBulletsArray.remove(at: 0)
                    }
                    
                    //remove monster bullets and decrease chippy health after they hit chippy
                    if(sprite.intersects(self.chippy)){
                        sprite.removeFromParent()
                        self.monsterBulletsArray.remove(at: 0)
                        self.ChippyhealthBar.xScale = self.ChippyhealthBar.xScale - (10*5)/100
                    }
                    
                }
            }
        }
    }
    
    
    
    
    func showHealthPowerup(){
        // Shows the Health Powerup and movement in random directions. Only One Health powerup at a time.
            self.healthPowerup = SKSpriteNode(imageNamed: "healthIncrease")
            self.healthPowerup.physicsBody = SKPhysicsBody(rectangleOf: self.healthPowerup.size)
            self.healthPowerup.name = "healthPowerup"
            self.healthPowerup.physicsBody?.categoryBitMask = 1
            self.healthPowerup.position.x = 50
            self.healthPowerup.position.y = self.size.height - 50

            self.healthPowerup.physicsBody?.collisionBitMask = 0
            addChild(self.healthPowerup)
            
            let healthMove = SKAction.applyImpulse(CGVector(dx: CGFloat.random(in: 50...self.size.width), dy: CGFloat.random(in: -self.size.height...0)), duration: 45)
            self.healthPowerup.run(SKAction.repeatForever(healthMove))
    }
    
    
    func removeHealthSprite(){
        
        self.enumerateChildNodes(withName: "healthPowerup") {
            node, stop in
            if (node is SKSpriteNode) {
                let healthPowerupSprite = node as! SKSpriteNode
                // Check if the node is not in the scene
                if (healthPowerupSprite.position.x < 40 || healthPowerupSprite.position.x > self.size.width - 40 || healthPowerupSprite.position.y < 40 || healthPowerupSprite.position.y > self.size.height - 40) {
                    healthPowerupSprite.removeFromParent()
                }
                // Remove health powerup after it hits chippy
                // Increase chippy health
                if (healthPowerupSprite.intersects(self.chippy)){
                    healthPowerupSprite.removeFromParent()
                    if (self.ChippyhealthBar.xScale < 4) {
                    self.ChippyhealthBar.xScale = self.ChippyhealthBar.xScale + 1.5
                    }
                }
            }
        }
    }
    
    func gameStopped(){

        if (self.corePresent == false){
            let winNode = SKSpriteNode(imageNamed: "win")
            winNode.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
            addChild(winNode)
            
            self.RestartButton = SKSpriteNode(imageNamed: "restartBtn")
            self.RestartButton.name = "restart"
            self.RestartButton.size = CGSize(width: (RestartButton.texture?.size().width)!, height: (RestartButton.texture?.size().height)!)
            self.RestartButton.position =  CGPoint(x: self.size.width*0.55, y: self.size.height*0.8)
            self.addChild(self.RestartButton)
            
            scene!.view?.isPaused = true
        }
        
        if (self.ChippyhealthBar.xScale <= 1){
          
            let loseNode = SKSpriteNode(imageNamed: "lose")
            loseNode.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
            addChild(loseNode)
            
            self.RestartButton = SKSpriteNode(imageNamed: "restartBtn")
            self.RestartButton.name = "restart"
            self.RestartButton.size = CGSize(width: (RestartButton.texture?.size().width)!, height: (RestartButton.texture?.size().height)!)
           self.RestartButton.position =  CGPoint(x: self.size.width*0.55, y: self.size.height*0.8)
            self.addChild(self.RestartButton)
            
            scene!.view?.isPaused = true
            
        }
    }
    
    
    func removeChippyBullet(){
        
        self.chippyBullet.name = "chippyBullet"
        self.enumerateChildNodes(withName: "chippyBullet") {
            node, stop in
            if(self.bulletsArray.count != 0){
                if (node is SKSpriteNode) {
                    let sprite = node as! SKSpriteNode
           
                    if (sprite.position.x < 100 || sprite.position.x > self.size.width - 100 || sprite.position.y < 100 || sprite.position.y > self.size.height - 100) {

                        sprite.removeFromParent()
                        self.bulletsArray.remove(at: 0)
                    }
                    if sprite.intersects(self.monster) {
                        sprite.removeFromParent()
                        self.bulletsArray.remove(at: 0)
                    }
                    
                }
            }
        }
    }
    
    
    func rmvMonster(){
        self.enumerateChildNodes(withName: "monster") {
            (node, stop) in
            self.monster = node as? SKSpriteNode
            if self.chippyBullet.intersects(self.monster){
                self.monster.removeFromParent()
                self.removeChippyBullet()
                self.monsterPartsCount = self.monsterPartsCount - 1
                
                let monsterHitSound = SKAction.playSoundFileNamed("monsterHit", waitForCompletion: true)
                self.run(monsterHitSound)

            }
        }
        
        if self.chippyBullet.intersects(self.eyeCore){
            
            self.monster.removeFromParent()
            self.eyeCore.removeFromParent()
            self.removeChippyBullet()
            print("core removed")
            self.monsterPartsCount = 0
            self.corePresent = false
            
            let monsterHitSound = SKAction.playSoundFileNamed("monsterHit", waitForCompletion: true)
            self.run(monsterHitSound)
        }
    }
    
    func movingchippy(){
        
        if (self.moveDirection == "up"){
            self.chippy.zRotation = .pi / 2
            if(self.chippy.position.y < self.size.height - self.chippy.size.height){
                let chippyMove = SKAction.moveBy(x: 0, y: 40, duration: 0.01)
                self.chippy.run(chippyMove)
            }
        }
            
        else if (self.moveDirection == "down"){
            self.chippy.zRotation = .pi / -2
            if(self.chippy.position.y > 0 + self.chippy.size.height){
                let chippyMove = SKAction.moveBy(x: 0, y: -(40), duration: 0.01)
                self.chippy.run(chippyMove)
            }
        }

        else if (self.moveDirection == "left"){
            self.chippy.zRotation = .pi
            if(self.chippy.position.x > 0 + self.chippy.size.width){
                let chippyMove = SKAction.moveBy(x: -(40), y: 0, duration: 0.01)
                self.chippy.run(chippyMove)
            }
        }
            
        else if (self.moveDirection == "right"){
            self.chippy.zRotation = 0
            if(self.chippy.position.x < self.size.width - self.chippy.size.width){
                let chippyMove = SKAction.moveBy(x: 40, y: 0, duration: 0.01)
                self.chippy.run(chippyMove)
            }
        }
        
    }
    
    override
    func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.touch = touches.first!
        let location = touch.location(in: self)
        let nodeTouched = atPoint(location).name
        self.mouseXPos = location.x
        self.mouseYPos = location.y
        
        
        if nodeTouched == "top"{
            self.moveDirection = "up"
        }
        else if nodeTouched == "bottom"{
            
            self.moveDirection = "down"
        }
        else if nodeTouched == "left"{
            
            self.moveDirection = "left"
        }
        else if nodeTouched == "right"{
            
            self.moveDirection = "right"
        }

        else {
            self.spawnBullet = "yes"
        }
        
        guard let mousePosition = touches.first?.location(in: self) else {
            return
        }
        print(mousePosition)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.touch = touches.first!
        let location = self.touch.location(in: self)
        let nodeTouched = atPoint(location).name
        
        self.mouseXPos = touch.location(in: self).x
        self.mouseYPos = touch.location(in: self).y
 
        if nodeTouched == "top"{
            self.moveDirection = "up"
        }
        else if nodeTouched == "bottom"{
            
            self.moveDirection = "down"
        }
        else if nodeTouched == "left"{
            
            self.moveDirection = "left"
        }
        else if nodeTouched == "right"{
            
            self.moveDirection = "right"
        }
            
        else {
            self.spawnBullet = "yes"
        }
        
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Restting the variables to their initial values after the touch is ended
        self.touch = touches.first!
        let location = self.touch.location(in: self)
        
        self.mouseXPos = touch.location(in: self).x
        self.mouseYPos = touch.location(in: self).y
        
        self.moveDirection = ""
        self.spawnBullet = "no"
        self.spawnBullet = "no"
        let nodeTouched = atPoint(location).name
        
        if (nodeTouched == "restart"){
            let scene = SKScene(fileNamed: "GameScene")
                        scene!.scaleMode = .aspectFill
                        view!.presentScene(scene)
        }
    }
    
}

