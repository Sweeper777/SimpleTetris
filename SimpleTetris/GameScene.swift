import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var startButton: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        self.view?.ignoresSiblingOrder = true
        let background = self.childNode(withName: "bg")!
        background.zPosition = 998
        let banner = background.childNode(withName: "banner") as! SKSpriteNode
        let moveLeftLittle = SKAction.moveBy(x: -3.5, y: 0, duration: 0.35)
        banner.zPosition = 999
        banner.run(moveLeftLittle)
        let moveLeft = SKAction.moveBy(x: -7, y: 0, duration: 0.7)
        let moveRight = SKAction.moveBy(x: 7, y: 0, duration: 0.7)
        let leftAndRight = SKAction.repeatForever(SKAction.sequence([moveRight, moveLeft]))
        banner.run(leftAndRight)
        
        startButton = background.childNode(withName: "startButton") as! SKSpriteNode
        startButton.zPosition = 1000
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
            }
        }
    }
}
