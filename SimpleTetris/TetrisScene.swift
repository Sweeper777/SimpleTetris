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
        downButton.onClick = { [weak self] in self?.fallingTetrimino.moveDown() }
        
        buttonGrid.setContent([leftButton, rightButton, rotateButton, downButton, NSNull(), NSNull()])
        background.addChild(buttonGrid)
        background.hlLayoutChildren()
        
        tetrisBoard = TetrisBoard(scene: self)
        fallingTetrimino = IShapedTetrimino(tetrisBoard: tetrisBoard, rotationIndex: 0)
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
