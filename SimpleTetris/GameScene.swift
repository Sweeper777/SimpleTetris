import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var startButton: SKSpriteNode!
    var gestureCheckbox: SKSpriteNode!
    var bgmCheckbox: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        self.view?.ignoresSiblingOrder = true
        let background = self.childNode(withName: "bg")!
        background.zPosition = 998
        let banner = background.childNode(withName: "banner") as! SKSpriteNode
        let moveLeftLittle = SKAction.moveBy(x: -1.5, y: 0, duration: 0.35)
        banner.zPosition = 999
        banner.run(moveLeftLittle)
        let moveLeft = SKAction.moveBy(x: -3, y: 0, duration: 0.7)
        let moveRight = SKAction.moveBy(x: 3, y: 0, duration: 0.7)
        let leftAndRight = SKAction.repeatForever(SKAction.sequence([moveRight, moveLeft]))
        banner.run(leftAndRight)
        
        startButton = background.childNode(withName: "startButton") as! SKSpriteNode
        startButton.zPosition = 1000
        
        gestureCheckbox = background.childNode(withName: "gestureCheckbox") as! SKSpriteNode
        gestureCheckbox.zPosition = 1000
        let gestureEnabled = UserDefaults.standard.bool(forKey: "gestures")
        gestureCheckbox.texture = SKTexture(imageNamed: gestureEnabled ? "gestureChecked" : "gestureUnchecked")
        
        bgmCheckbox = background.childNode(withName: "bgmCheckbox") as! SKSpriteNode
        bgmCheckbox.zPosition = 1000
        let bgmEnabled = UserDefaults.standard.bool(forKey: "bgm")
        bgmCheckbox.texture = SKTexture(imageNamed: bgmEnabled ? "bgmChecked" : "bgmUnchecked")
        
        let bestScoreLabel = background.childNode(withName: "bestScoreBg")!.childNode(withName: "bestScoreLabel") as! SKLabelNode
        bestScoreLabel.text = String(UserDefaults.standard.integer(forKey: "bestScore"))
        bestScoreLabel.zPosition = 1002
        bestScoreLabel.parent?.zPosition = 1001
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if self.nodes(at: location).contains(startButton) {
                let atlas = SKTextureAtlas(named: "startButton")
                let animation = SKAction.animate(with: [atlas.textureNamed("startButton_p"), atlas.textureNamed("startButton")], timePerFrame: 0.2)
                startButton.run(SKAction.sequence([animation, SKAction.run {
                    let tetrisScene = TetrisScene(fileNamed: "TetrisScene")
                    tetrisScene!.scaleMode = .aspectFit
                    let transition = SKTransition.push(with: .left, duration: 0.5)
                    self.view!.presentScene(tetrisScene!, transition: transition)
                    }]))
                break
            } else if self.nodes(at: location).contains(gestureCheckbox) {
                let gestureEnabled = UserDefaults.standard.bool(forKey: "gestures")
                let animation = SKAction.setTexture(SKTexture(imageNamed: !gestureEnabled ? "gestureChecked" : "gestureUnchecked"))
                gestureCheckbox.run(animation)
                UserDefaults.standard.set(!gestureEnabled, forKey: "gestures")
            } else if self.nodes(at: location).contains(bgmCheckbox) {
                let bgmEnabled = UserDefaults.standard.bool(forKey: "bgm")
                let animation = SKAction.setTexture(SKTexture(imageNamed: !bgmEnabled ? "bgmChecked" : "bgmUnchecked"))
                bgmCheckbox.run(animation)
                UserDefaults.standard.set(!bgmEnabled, forKey: "bgm")
                
                if let vc = (UIApplication.shared.delegate as? AppDelegate)?.window?.rootViewController as? GameViewController {
                    vc.audioPlayer.volume = !bgmEnabled ? 1.0 : 0.0
                }
            }
        }
    }
}
