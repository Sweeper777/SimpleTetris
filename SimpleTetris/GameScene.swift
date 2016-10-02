import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    
    override func didMove(to view: SKView) {
        let banner = self.childNode(withName: "banner") as! SKSpriteNode
        let moveLeftLittle = SKAction.moveBy(x: -25, y: 0, duration: 0.35)
        banner.run(moveLeftLittle)
        let moveLeft = SKAction.moveBy(x: -50, y: 0, duration: 0.7)
        let moveRight = SKAction.moveBy(x: 50, y: 0, duration: 0.7)
        let leftAndRight = SKAction.repeatForever(SKAction.sequence([moveRight, moveLeft]))
        banner.run(leftAndRight)
    }
}
