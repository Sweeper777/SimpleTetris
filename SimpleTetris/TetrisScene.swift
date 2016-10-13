import SpriteKit
import HLSpriteKit

class TetrisScene: SKScene {
    var background: SKSpriteNode!
    var tetrisGrid: HLGridNode!
    var tetrisBoard: TetrisBoard!
    var fallingTetrimino: Tetrimino!
    var isGameOver = false
    var scoreLabel: SKLabelNode!
    var bestScoreLabel: SKLabelNode!
    
    override func didMove(to view: SKView) {
        background = self.childNode(withName: "bg") as! SKSpriteNode
        self.view?.ignoresSiblingOrder = true
        let anchorPoint = NSValue(cgPoint: CGPoint(x: 0.5, y: 0.5))
        let tableLayout = HLTableLayoutManager(columnCount: 1, columnWidths: [(0.0)], columnAnchorPoints: [anchorPoint], rowHeights: [(0.0)])!
        tableLayout.rowSeparator = 15
        background.hlSetLayoutManager(tableLayout)
        
        let scoreboardNode = SKSpriteNode(color: UIColor.yellow.withAlphaComponent(0.77), size: CGSize(width: 700, height: 160))
        scoreboardNode.zPosition = 1001
        
        scoreLabel = SKLabelNode(text: "SCORE:           0")
        scoreLabel.fontSize = 61
        scoreLabel.fontName = "Courier-Bold"
        scoreLabel.horizontalAlignmentMode = .center
        scoreLabel.fontColor = UIColor.black
        scoreLabel.position = CGPoint(x: 10, y: 5)
        scoreboardNode.addChild(scoreLabel)
        
        bestScoreLabel = SKLabelNode(text: "BEST:            0")
        bestScoreLabel.fontSize = 61
        bestScoreLabel.horizontalAlignmentMode = .center
        bestScoreLabel.fontName = "Courier-Bold"
        bestScoreLabel.fontColor = UIColor.black
        bestScoreLabel.position = CGPoint(x: 10, y: -50)
        scoreboardNode.addChild(bestScoreLabel)
        
        background.addChild(scoreboardNode)
        
        tetrisGrid = HLGridNode(gridWidth: 10, squareCount: 200, anchorPoint: CGPoint(x: 0.5, y: 0.5), layoutMode: .fill, squareSize: CGSize(width: 50, height: 50), backgroundBorderSize: 0, squareSeparatorSize: 0)
        tetrisGrid.zPosition = 1000
        tetrisGrid.backgroundColor = UIColor.black
        tetrisGrid.squareColor = UIColor.black
        background.addChild(tetrisGrid)
        
        let buttonGrid = HLGridNode(gridWidth: 6, squareCount: 6, anchorPoint: CGPoint(x: 0.5, y: 0.5), layoutMode: .fill, squareSize: CGSize(width: 100, height: 100), backgroundBorderSize: 0, squareSeparatorSize: 10)!
        buttonGrid.backgroundColor = UIColor.clear
        buttonGrid.squareColor = UIColor.clear
        
        let leftButton = ButtonNode(imageNamed: "leftButton")
        leftButton.pressedTexture = SKTexture(imageNamed: "leftButton_p")
        leftButton.unpressedTexture = SKTexture(imageNamed: "leftButton")
        leftButton.onClick = { [weak self] in self?.fallingTetrimino?.move(.left) }
        
        let rightButton = ButtonNode(imageNamed: "rightButton")
        rightButton.pressedTexture = SKTexture(imageNamed: "rightButton_p")
        rightButton.unpressedTexture = SKTexture(imageNamed: "rightButton")
        rightButton.onClick = { [weak self] in self?.fallingTetrimino?.move(.right) }
        
        let rotateButton = ButtonNode(imageNamed: "rotateButton")
        rotateButton.pressedTexture = SKTexture(imageNamed: "rotateButton_p")
        rotateButton.unpressedTexture = SKTexture(imageNamed: "rotateButton")
        rotateButton.onClick = { [weak self] in (self?.fallingTetrimino as? Rotatable)?.rotate() }
        
        let downButton = ButtonNode(imageNamed: "downButton")
        downButton.pressedTexture = SKTexture(imageNamed: "downButton_p")
        downButton.unpressedTexture = SKTexture(imageNamed: "downButton")
        downButton.onClick = { [weak self] in self?.fallingTetrimino?.moveDown() }
        
        let forcedDownButton = ButtonNode(imageNamed: "forcedDownButton")
        forcedDownButton.pressedTexture = SKTexture(imageNamed: "forcedDownButton_p")
        forcedDownButton.unpressedTexture = SKTexture(imageNamed: "forcedDownButton")
        forcedDownButton.onClick = { [weak self] in self?.fallingTetrimino?.forcedMoveDown() }
        
        buttonGrid.setContent([leftButton, rightButton, rotateButton, downButton, forcedDownButton, NSNull()])
        background.addChild(buttonGrid)
        background.hlLayoutChildren()
        
        tetrisBoard = TetrisBoard(scene: self)
        tetrisBoard.addTetrimino()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isGameOver {
            let scene = GameScene(fileNamed: "GameScene")!
            let transition = SKTransition.push(with: .right, duration: 0.5)
            scene.scaleMode = .aspectFit
            self.view!.presentScene(scene, transition: transition)
        } else {
            for touch in touches {
                let location = touch.location(in: self)
                if let button = self.nodes(at: location).first as? ButtonNode {
                    button.onTouch()
                }
            }
        }
    }
    
    func gameOver() {
        self.removeAllActions()
        self.fallingTetrimino = nil
        isGameOver = true
        let gameOverBanner = SKSpriteNode(imageNamed: "gameOver")
        gameOverBanner.alpha = 0
        gameOverBanner.zPosition = 2000
        gameOverBanner.size = CGSize(width: 700, height: 336.5)
        addChild(gameOverBanner)
        let translucentNode = SKSpriteNode(color: UIColor.black.withAlphaComponent(0.8), size: self.size)
        translucentNode.alpha = 0
        translucentNode.zPosition = 1999
        addChild(translucentNode)
        let fadeIn = SKAction.fadeIn(withDuration: 0.5)
        gameOverBanner.run(fadeIn)
        translucentNode.run(fadeIn)
        
    }
}
