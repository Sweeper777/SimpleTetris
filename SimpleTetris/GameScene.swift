import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var startButton: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        let banner = self.childNode(withName: "banner") as! SKSpriteNode
        let moveLeftLittle = SKAction.moveBy(x: -25, y: 0, duration: 0.35)
        banner.run(moveLeftLittle)
        let moveLeft = SKAction.moveBy(x: -50, y: 0, duration: 0.7)
        let moveRight = SKAction.moveBy(x: 50, y: 0, duration: 0.7)
        let leftAndRight = SKAction.repeatForever(SKAction.sequence([moveRight, moveLeft]))
        banner.run(leftAndRight)
        
        startButton = self.childNode(withName: "startButton") as! SKSpriteNode
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if startButton.frame.contains(touch.location(in: startButton)) {
                let atlas = SKTextureAtlas(named: "startButton")
                let animation = SKAction.animate(with: [atlas.textureNamed("startButton_p"), atlas.textureNamed("startButton")], timePerFrame: 0.2)
                startButton.run(animation)
            }
        }
    }
}
