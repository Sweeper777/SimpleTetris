import SpriteKit
import HLSpriteKit

class TetrisScene: SKScene {
    var background: SKSpriteNode!
    var tetrisGrid: HLGridNode!
    var tetrisBoard: TetrisBoard!
    
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
        let block = TetrisBlock(x: 0, y: 0, texture: SKTexture(imageNamed: "ltetrimino"), tetrisBoard: tetrisBoard)
    }
}
