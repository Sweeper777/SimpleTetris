import SpriteKit
import HLSpriteKit

class TetrisScene: SKScene {
    var background: SKSpriteNode!
    var tetrisGrid: HLGridNode!
    var tetrisBoard: TetrisBoard!
    var fallingTetrimino: Tetrimino!
    
    override func didMove(to view: SKView) {
        background = self.childNode(withName: "bg") as! SKSpriteNode
        self.view?.ignoresSiblingOrder = true
        let anchorPoint = NSValue(cgPoint: CGPoint(x: 0.5, y: 0.5))
        let tableLayout = HLTableLayoutManager(columnCount: 1, columnWidths: [(0.0)], columnAnchorPoints: [anchorPoint], rowHeights: [(0.0)])!
        tableLayout.rowSeparator = 15
        background.hlSetLayoutManager(tableLayout)
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
        leftButton.onClick = { print("pressed") }
        
        buttonGrid.setContent([leftButton, NSNull(), NSNull(), NSNull(), NSNull(), NSNull()])
        background.addChild(buttonGrid)
        background.hlLayoutChildren()
        
        tetrisBoard = TetrisBoard(scene: self)
        fallingTetrimino = IShapedTetrimino(tetrisBoard: tetrisBoard, rotationIndex: 0)
        
        let moveLeft = SKAction.run {
            self.fallingTetrimino.move(.left)
        }
        let moveRight = SKAction.run {
            self.fallingTetrimino.move(.right)
        }
        let wait = SKAction.wait(forDuration: 3.5)
        let longWait = SKAction.wait(forDuration: 7)
        self.run(SKAction.sequence([wait, moveLeft]))
        self.run(SKAction.sequence([longWait, moveRight]))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if let button = self.nodes(at: location).first as? ButtonNode {
                button.onTouch()
            }
        }
    }
}
