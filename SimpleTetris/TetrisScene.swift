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
        background.hlSetLayoutManager(HLTableLayoutManager(columnCount: 1, columnWidths: [(0.0)], columnAnchorPoints: [anchorPoint], rowHeights: [(0.0)]))
        tetrisGrid = HLGridNode(gridWidth: 10, squareCount: 200, anchorPoint: CGPoint(x: 0.5, y: 0.5), layoutMode: .fill, squareSize: CGSize(width: 50, height: 50), backgroundBorderSize: 0, squareSeparatorSize: 0)
        tetrisGrid.zPosition = 1000
        tetrisGrid.backgroundColor = UIColor.black
        tetrisGrid.squareColor = UIColor.black
        background.addChild(tetrisGrid)
        
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
}
